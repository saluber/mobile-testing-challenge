//
//  Tests.m
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
#import "Tests.h"

@implementation Tests

/* Model (Loaded Data) Test Cases*/

/* ---------------------------------------------------------*/
// Test Case: testUserLoaded
// Verifies SCMe data loaded correctly from SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
+ (void)testUserLoaded
{
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
        // Verify correct user ID loaded
        NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
        if (![actual_id isEqualToNumber:[SCMe sharedMe].identifier]) {
            NSLog(@"Incorrect user ID loaded.");
        }
        
        // Verify correct permalink loaded
        NSString * actual = @"scapptest";
        if(![actual isEqualToString:[SCMe sharedMe].permalink]) {
            NSLog(@"Incorrect user permalink loaded.");
        }
        
        // Verify correct username loaded
        actual = @"SCAppTest";
        if (![actual isEqualToString:[SCMe sharedMe].username]) {
            NSLog(@"Incorrect username loaded.");
        }
        
        // Verify correct uri loaded
        actual = @"https://api.soundcloud.com/users/27614868";
        NSURL * local = [SCMe sharedMe].uri;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect uri loaded.");
        }
        
        // Verify correct permalinkURL loaded
        actual = @"http://soundcloud.com/scapptest";
        local = [SCMe sharedMe].permalinkURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect permalink URL loaded.");
        }
        
        // Verify correct avatarURL loaded
        actual = @"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0";
        local = [SCMe sharedMe].avatarURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect avatar URL loaded.");
        }
    }
}

/* ---------------------------------------------------------*/
// Test Case: testArchivesUserLoaded
// Verifies SCMe data loaded correctly from archived SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
+ (void) testArchivesUserLoaded
{
    /* Test cases from testUserLoaded but with archive from previous test*/
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
        // Verify correct user ID loaded
        NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
        if (![actual_id isEqualToNumber:[SCMe sharedMe].identifier]) {
            NSLog(@"Incorrect user ID loaded.");
        }
        
        // Verify correct permalink loaded
        NSString * actual = @"scapptest";
        if(![actual isEqualToString:[SCMe sharedMe].permalink]) {
            NSLog(@"Incorrect user permalink loaded.");
        }
        
        // Verify correct username loaded
        actual = @"SCAppTest";
        if (![actual isEqualToString:[SCMe sharedMe].username]) {
            NSLog(@"Incorrect username loaded.");
        }
        
        // Verify correct uri loaded
        actual = @"https://api.soundcloud.com/users/27614868";
        NSURL * local = [SCMe sharedMe].uri;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect uri loaded.");
        }
        
        // Verify correct permalinkURL loaded
        actual = @"http://soundcloud.com/scapptest";
        local = [SCMe sharedMe].permalinkURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect permalink URL loaded.");
        }
        
        // Verify correct avatarURL loaded
        actual = @"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0";
        local = [SCMe sharedMe].avatarURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect avatar URL loaded.");
        }
        
        // Clear Application's Archives for next test
        [TestHelpers clearArchives];
    }
}

/* ---------------------------------------------------------*/
// Test Case: testNoArchivesUserLoaded
// Verifies SCMe data loaded correctly from online SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
+ (void)testNoArchiveUserLoaded
{
    /* Test cases from testUserLoaded but with archives cleared at end of prev test*/
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
    
        // Verify correct user ID loaded
        NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
        if (![actual_id isEqualToNumber:[SCMe sharedMe].identifier]) {
            NSLog(@"Incorrect user ID loaded.");
        }
        
        // Verify correct permalink loaded
        NSString * actual = @"scapptest";
        if(![actual isEqualToString:[SCMe sharedMe].permalink]) {
            NSLog(@"Incorrect user permalink loaded.");
        }
        
        // Verify correct username loaded
        actual = @"SCAppTest";
        if (![actual isEqualToString:[SCMe sharedMe].username]) {
            NSLog(@"Incorrect username loaded.");
        }
        
        // Verify correct uri loaded
        actual = @"https://api.soundcloud.com/users/27614868";
        NSURL * local = [SCMe sharedMe].uri;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect uri loaded.");
        }
        
        // Verify correct permalinkURL loaded
        actual = @"http://soundcloud.com/scapptest";
        local = [SCMe sharedMe].permalinkURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect permalink URL loaded.");
        }
        
        // Verify correct avatarURL loaded
        actual = @"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0";
        local = [SCMe sharedMe].avatarURL;
        if (![actual isEqualToString: local.absoluteString]) {
            NSLog(@"Incorrect avatar URL loaded.");
        }
    }
}

/* Controller/View testing */

/* ---------------------------------------------------------*/
// Test Case: testViewNavigation
// Verifies view controllers and corresponding loaded views
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies information in initial view Favourites
// 3. Uses rootViewController (TabBarController) to navigate to Tracks
// 4. Verifies information in Tracks view
// 5. Uses rootViewController (TabBarController) to navigate to You
// 6. Verifies information in Tracks view
/* ---------------------------------------------------------*/
+ (void)testViewNavigation: (SCTabBarController*) tab_bar_controller
{
    // Verify moving btwn PresentedControllers: FavViewController, TracksViewController, YouViewController
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
        // FavViewController is default, verify it!
        NSString * title = [[NSString alloc]initWithString:[tab_bar_controller.selectedViewController title]];
        if(![title isEqualToString:@"FavNavigationController"]) {
            NSLog(@"Incorrect view loaded! Expected: FavNavigationController, Actual:%@", title);
        }

        // Navigate to TracksViewController
        [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:1]];
        
        // Verify TracksViewController
        title = [[NSString alloc]initWithString:[tab_bar_controller.selectedViewController title]];
        if(![title isEqualToString:@"TracksNavigationController"]) {
            NSLog(@"Incorrect view loaded! Expected: TracksNavigationController, Actual:%@", title);
        }
       
        // Navigate to YouViewController
        [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:2]];
        
        // Verify YouViewController
        title = [[NSString alloc]initWithString:[tab_bar_controller.selectedViewController title]];
        if(![title isEqualToString:@"SCAppTest"]) {
            NSLog(@"Incorrect view loaded! Expected: SCAppTest, Actual:%@", title);
        }
    }
    
    /* Note: Doesn't test navigation bar because same information 
        is already parsed for account and verified there! */
}

/* ---------------------------------------------------------*/
// Test Case: testYouViewController
// Verifies logout action on the You view
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Uses rootViewController (TabBarController) to navigate to You
// 3. Loads UITableViewController for You view controller
// 4. Presses logout button
// 5. Verifies account authentiation is removoked
/* ---------------------------------------------------------*/
+ (void)testYouViewController
{
     // Verify logout
    if([SCSoundCloud account] && [SCMe sharedMe]) {
        NSLog(@"Logout didn't revoke account authentication.");
    }
}

/* See SCFavouitesViewController for favorites/track test functions */
@end
