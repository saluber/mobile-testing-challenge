//
//  TestHelpers.h
//  TestHelpers
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"
#import "SCTabBarController.h"


#ifndef SoundCloudiOSTesting_TestHelperFunctions_h
#define SoundCloudiOSTesting_TestHelperFunctions_h

/* Test hooks and helper apps for testing app */

@interface TestHelpers

+ (void) clearArchives;
+ (void) addFavorite: (NSString *) songID;
+ (void) removeFavorite: (NSString*) songID;
+ (void) addTrack: (NSDictionary*) songInfo;
+ (void) removeTrack:(NSString*) songID;
+ (id) getUserProperties: (NSString*)property;
+ (NSArray*) getSubresource: (NSString*) subresourceName;

@end

#endif