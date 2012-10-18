//
//  SCMe.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCObjectBase.h"

extern NSString *const kSCMeLoadedUserInfoNotification;
extern NSString *const kSCMeLoadedSubresourceNotification;

/**
 @class SC user account information.
 Not all info parsed, only that currently under use
 */

@interface SCMe : SCObjectBase

@property (strong, readonly) NSNumber *identifier;
@property (strong, readonly) NSString *permalink;
@property (strong, readonly) NSString *username;
@property (strong, readonly) NSURL *uri;
@property (strong, readonly) NSURL *permalinkURL;
@property (strong, readonly) NSURL *avatarURL;

/** ... just the first few properties for now ... */

/** Subresources */
@property (strong, readonly) NSDictionary *subresources;

+ (SCMe*) sharedMe;

/**
 Request a particular user subresource
 @param resource Resource name
 @param klass Object class to parse objects into
 */
- (void) requestSubresourceNamed:(NSString*) resource 
                     objectClass:(__unsafe_unretained Class) klass;

@end
