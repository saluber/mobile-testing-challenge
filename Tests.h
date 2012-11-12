//
//  Tests.h
//  Tests
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"
#import "SCTabBarController.h"
#import "TestHelpers.h"
#import "SCTrackTableBaseViewController.h"
#import "SCTrackTableCell.h"
#import "SCFavouritesViewController.h"
#import "SCUserTracksViewController.h"
#import "SCYouViewController.h"

@interface Tests

+ (void)testUserLoaded;
+ (void) testArchivesUserLoaded;
+ (void)testNoArchiveUserLoaded;
+ (void)testViewNavigation: (SCTabBarController*) tab_bar_controller;
+ (void)testYouViewController;

@end
