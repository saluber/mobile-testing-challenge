//
//  SCMe+Private.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

@interface SCMe ()
@property (strong, readwrite) NSNumber *identifier;
@property (strong, readwrite) NSString *permalink;
@property (strong, readwrite) NSString *username;
@property (strong, readwrite) NSURL *uri;
@property (strong, readwrite) NSURL *permalinkURL;
@property (strong, readwrite) NSURL *avatarURL;
@property (strong, readwrite) NSDictionary *subresources;

+ (void) accountDidChange:(NSNotification*)note;
+ (void) setSharedMe:(SCMe*) me;
+ (void) archive;
+ (SCMe*) dearchive;
+ (NSString*) archivePath;

@end
