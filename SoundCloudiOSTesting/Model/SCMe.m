//
//  SCMe.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCMe.h"
#import "SCMe+Private.h"
#import "SCTrack.h"

__strong static SCMe* _sharedMe = nil;
NSString *const kSCMeLoadedUserInfoNotification = @"SCMeLoadedUserInfoNotification";
NSString *const kSCMeLoadedSubresourceNotification = @"SCMeLoadedSubresourceNotification";

@implementation SCMe
@synthesize identifier=_identifier, permalink=_permalink, username=_username, uri=_uri;
@synthesize permalinkURL=_permalinkURL, subresources=_subresources, avatarURL=_avatarURL;

+ (void) setSharedMe:(SCMe*) me {
  // Me changed?
  BOOL notify = !SAFE_EQUAL(me, [self sharedMe]);
  
  @synchronized([SCMe class]) {
    _sharedMe = me;
  }  
  
  // the user changed?
  if (notify) {
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:kSCMeLoadedUserInfoNotification
     object:me];
  }
}

+ (SCMe*) sharedMe {
  SCMe *ret = nil;
  @synchronized([SCMe class]) {
    ret = _sharedMe;
  }
  return ret;
}

+ (void) initialize {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (self == [SCMe class]) {
      // load shared instance from disk?
      [self setSharedMe:[self dearchive]];
      
      [[NSNotificationCenter defaultCenter] 
       addObserver:self 
       selector:@selector(accountDidChange:) 
       name:SCSoundCloudAccountDidChangeNotification 
       object:nil];
      
      // might already have an account by now...
      [self accountDidChange:nil];
    }
  });
}

+ (void) accountDidChange:(NSNotification*)note {
  if ([[SCSoundCloud account] identifier]) {
    
    if (![self sharedMe]) {
      // request me
      NSString *urlString = [NSString stringWithFormat:
                             @"%@me.json",
                             kSCSoundCloudAPIURL];
      
      NSURL *url = [NSURL URLWithString:urlString];
      
      [SCRequest performMethod:SCRequestMethodGET 
                    onResource:url 
               usingParameters:nil 
                   withAccount:[SCSoundCloud account]  
        sendingProgressHandler:^(unsigned long long bytesSend, 
                                 unsigned long long bytesTotal) 
      {
      } responseHandler:^(NSURLResponse *response, 
                          NSData *responseData, 
                          NSError *error) 
      {
        id obj = [responseData objectFromJSONData];
        [self setSharedMe:[SCMe objectWithDictionary:obj]];
      }];
      [self archive];
    } 
  } else {
    // reset me...
    [self setSharedMe:nil];
    [self archive];
  } 
}

+ (NSString*) archivePath {
  NSString *path = nil;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  path = [paths count] ? [paths objectAtIndex:0] : nil;
  return [path stringByAppendingPathComponent:@"scme.arch"];
}

+ (SCMe*) dearchive {
  NSData *data = [[NSData alloc] initWithContentsOfFile:[self archivePath]];
  return data ? [NSKeyedUnarchiver unarchiveObjectWithData:data] : nil;
}

+ (void) archive {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[SCMe sharedMe]];
  [data writeToFile:[[self class] archivePath] atomically:YES];
}

- (id) initWithDictionary:(NSDictionary *)dict {
  if ((self = [super initWithDictionary:dict])) {
    self.identifier = [dict objectForKey:@"id"];
    self.permalink = [dict objectForKey:@"permalink"];
    self.username = [dict objectForKey:@"username"];
    self.uri = [NSURL URLWithString:[dict objectForKey:@"uri"]];
    self.permalinkURL = [NSURL URLWithString:[dict objectForKey:@"permalink_url"]];
    
    self.avatarURL = [NSURL URLWithString:[dict objectForKey:@"avatar_url"]];
    //
    self.subresources = [NSDictionary dictionary];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.identifier forKey:@"id"];
  [encoder encodeObject:self.permalink forKey:@"permalink"];
  [encoder encodeObject:self.username forKey:@"username"];
  [encoder encodeObject:self.uri forKey:@"uri"];
  [encoder encodeObject:self.permalinkURL forKey:@"permalinkURL"];
  
  [encoder encodeObject:self.avatarURL forKey:@"avatarURL"];
  
  // subresources...
  [encoder encodeObject:self.subresources forKey:@"subresources"];
}

- (id)initWithCoder:(NSCoder *)decoder {
  if ((self = [super initWithCoder:decoder])) {
    self.identifier = [decoder decodeObjectForKey:@"id"];
    self.permalink = [decoder decodeObjectForKey:@"permalink"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.uri = [decoder decodeObjectForKey:@"uri"];
    self.permalinkURL = [decoder decodeObjectForKey:@"permalinkURL"];
    
    self.avatarURL = [decoder decodeObjectForKey:@"avatarURL"];
    
    // subresources
    self.subresources = [decoder decodeObjectForKey:@"subresources"];
  }
  return self;
}

- (void) requestSubresourceNamed:(NSString*) resource 
                     objectClass:(__unsafe_unretained Class) klass
{
  if (![self.subresources objectForKey:resource]) {
    NSString *urlString = [NSString stringWithFormat:@"%@users/%@/%@.json",
                           kSCSoundCloudAPIURL, self.identifier, resource];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [SCRequest performMethod:SCRequestMethodGET 
                  onResource:url 
             usingParameters:nil 
                 withAccount:[SCSoundCloud account] 
      sendingProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal) 
     {
     } responseHandler:^(NSURLResponse *response, 
                         NSData *responseData, 
                         NSError *error) 
     {
       NSArray *dicts = [responseData objectFromJSONData];
       NSMutableArray *mute = [[NSMutableArray alloc] initWithCapacity:[dicts count]];
       
       for (NSDictionary *dict in [responseData objectFromJSONData]) {
         [mute addObject:[klass objectWithDictionary:dict]];
       }
       
       // don't change unless the value is actually different...
       if (!SAFE_EQUAL(mute, [self.subresources objectForKey:resource])) {
         NSArray *immutable = [NSArray arrayWithArray:mute];
         
         @synchronized(self.subresources) {
           NSMutableDictionary *dict = [self.subresources mutableCopy];
           [dict setValue:immutable forKey:resource];
           self.subresources = [NSDictionary dictionaryWithDictionary:dict];
         }
         
         // send notification
         [[NSNotificationCenter defaultCenter] 
          postNotificationName:kSCMeLoadedSubresourceNotification 
          object:nil 
          userInfo:[NSDictionary dictionaryWithObject:immutable forKey:resource]];
         
         // save to disk...
         [SCMe archive];
       }       
     }];
  }
}

@end
