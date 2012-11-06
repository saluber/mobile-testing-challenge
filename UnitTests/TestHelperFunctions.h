//
//  TestHelperFunctions.h
//  TestHelperFunctions
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"
#import "SCTabBarController.h"

/* Test hooks and helper apps for testing app */

@interface TestHelperFunctions

+ (void) clearArchives;
+ (void) addFavorite: (NSString *) songID;
+ (void) removeFavorite: (NSString*) songID;
+ (void) addTrack: (NSDictionary*) songInfo;
+ (void) removeTrack:(NSString*) songID;
+ (id) getUserProperties: (NSString*)property;
+ (NSArray*) getSubresource: (NSString*) subresourceName;

@end