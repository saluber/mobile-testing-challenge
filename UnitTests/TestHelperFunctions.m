//
//  TestHelperFunctions.m
//  TestHelperFunctions
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

/* Helper Functions */

#import "TestHelperFunctions.h"
#import "SCMe.h"

@implementation TestHelperFunctions

// Clear Application Archives
+ (void) clearArchives {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:nil];
    [data writeToFile:[[SCMe class] archivePath] atomically:YES];
}

// Archive path
+ (NSString*) archivePath {
  NSString *path = nil;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 
                                                       NSUserDomainMask, 
                                                       YES);
  path = [paths count] ? [paths objectAtIndex:0] : nil;
  return [path stringByAppendingPathComponent:@"scme.arch"];
}

// Added as a test hook for adding a song to favorites
+ (void) addFavorite: (NSString *) songID {
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me/favorites/%@", kSCSoundCloudAPIURL, songID];
    SCAccount *account = [SCSoundCloud account];
    
    if (account) {
        [SCRequest performMethod:SCRequestMethodPUT
                      onResource:[NSURL URLWithString:urlString]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if (error) {
                         // Error occured outside of testing scope
                         NSLog(@"Error occured during favorites add: %@", [error localizedDescription]);
                     }
                 }];
    }
}

// Added as a test hook for removing a song from favorites
+ (void) removeFavorite: (NSString*) songID {
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me/favorites/%@", kSCSoundCloudAPIURL, songID];
    SCAccount *account = [SCSoundCloud account];
    
    if (account) {
        [SCRequest performMethod:SCRequestMethodDELETE
                      onResource:[NSURL URLWithString:urlString]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if (error) {
                         // Error occured outside of testing scope
                         NSLog(@"Error occured during favorites delete: %@", [error localizedDescription]);
                     }
                 }];
    }
}

// Added as a test hook for adding a song to tracks
+ (void) addTrack: (NSDictionary*) songInfo {
    NSString *songID = [[songInfo objectForKey:(@"id")] stringValue];
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me/tracks/%@", kSCSoundCloudAPIURL, songID];
    SCAccount *account = [SCSoundCloud account];
    
    if (account) {
        [SCRequest performMethod:SCRequestMethodPUT
                      onResource:[NSURL URLWithString:urlString]
                 usingParameters:songInfo
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if (error) {
                         // Error occured outside of testing scope
                         NSLog(@"Error occured during tracks add: %@", [error localizedDescription]);
                     }
                 }];
    }
}

// Added as a test hook for removing a song from tracks
+ (void) removeTrack:(NSString*) songID {
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me/tracks/%@", kSCSoundCloudAPIURL, songID];
    SCAccount *account = [SCSoundCloud account];
    
    if (account) {
        [SCRequest performMethod:SCRequestMethodDELETE
                      onResource:[NSURL URLWithString:urlString]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if (error) {
                         // Error occured outside of testing scope
                         NSLog(@"Error occured during tracks delete: %@", [error localizedDescription]);
                     }
                 }];
    }
}

// Added as a test hook for getting all user properties
+ (id) getUserProperties: (NSString*)property {
    __block id value = nil;
    __block id dict = nil;
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me.json", kSCSoundCloudAPIURL];
    NSURL *url = [NSURL URLWithString:urlString];
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:url
             usingParameters:nil
                 withAccount:[SCSoundCloud account]
      sendingProgressHandler:nil
            responseHandler:^(NSURLResponse *response, 
                          NSData *responseData, 
                          NSError *error) 
      {
        // Error check for failed account request
          if (error) {
              NSLog(@"Unable to request SoundCloud account with error: %@", [error localizedDescription]);
          }
          
        dict = [responseData objectFromJSONData];
        value = [dict objectForKey:@"id"];
      }
    ];
            
    return value;
}

// Added as a test hook for getting user subresource
+ (NSArray *) getSubresource: (NSString*) subresourceName {
    __block NSArray * subresource = nil;
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me/%@.json", kSCSoundCloudAPIURL, subresourceName];
    SCAccount *account = [SCSoundCloud account];
    
    if (account) {
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:urlString]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if (error) {
                         // Error occured outside of testing scope
                         NSLog(@"Error occured during subresource request: %@", [error localizedDescription]);
                     }
                     subresource = [data objectFromJSONData];
                 }];
    }
    return subresource;
}

@end