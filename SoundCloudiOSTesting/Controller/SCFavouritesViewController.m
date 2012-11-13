//
//  SCFavouritesViewController.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCFavouritesViewController.h"
#import "TestHelpers.h"

@interface SCFavouritesViewController ()
@end

@implementation SCFavouritesViewController

- (NSString*) resourceName { return @"favorites"; }

/* ---------------------------------------------------------*/
// Test Case: testFavouritesViewController
// Verifies track information loaded and maintained by favorites view
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. SCFavouritesNavigationController is default starting controller
// 3. Loads UITableViewController for Favourites view controller
// 4. Verifies favourites track information with test SoundCloud account
/* ---------------------------------------------------------*/
- (void)testViewController
{
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
    
        // Verify tracks loaded match actual account favourite tracks
        NSArray * propertyArray = [[SCMe sharedMe].subresources objectForKey:@"favorites"];
        
        // Verify number of tracks
        NSInteger numFavs = [propertyArray count];
        if (numFavs != 2) {
            NSLog(@"Incorrect number of favorites tracks.");
        }
        
        // Verify first song information
        SCTrack * track = [propertyArray objectAtIndex:0];
        NSString* title = track.title;
        if(![title isEqualToString:@"Joris Voorn - Sensation Innerspace NYC 26.10.2012"]) {
            NSLog(@"Mismatched expected first track title: %@", title);
        }
        
        // Verify second song information
        track = [propertyArray objectAtIndex:1];
        title = track.title;
            if(![title isEqualToString:@"Digitalism - Zdarlight (Fedde Le Grand & Deniz Koyu Remix) preview"]) {
                NSLog(@"Mismatched expected second track title: %@", title);
            }
    }
}

/* ---------------------------------------------------------*/
// Test Case: testFavouritesViewController
// Verifies that table updates with external favourites list changes
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. SCFavouritesNavigationController is default starting controller
// 3. Loads UITableViewController for Favourites view controller
// 4. Uses test hook to remove an item from favorites list
// 5. Verifies favourites track information with test SoundCloud account
// 6. Uses test hook to add an item to favorites list
// 7. Verifies favourites track information with test SoundCloud account
/* ---------------------------------------------------------*/
- (void) testViewDataWithChange
{
    if ([SCMe sharedMe] && [SCSoundCloud account]) {
    
        // Only execute test once to avoid async issues with add/delete
        static dispatch_once_t onceTestToken;
        dispatch_once(&onceTestToken, ^{
        
            // Test hook removes favorite
            [TestHelpers removeFavorite:@"58224511"];
            
            NSArray * propertyArray = [[SCMe sharedMe].subresources objectForKey:@"favorites"];
            
            // Verify number of favorite tracks from test account
            NSInteger numFavs = [propertyArray count];
            if(numFavs != 1) {
                NSLog(@"Table isn't updated with deleted fav track.");
            }
            
            // Test hook re-adds favorite
            [TestHelpers addFavorite:@"58224511"];
            
            // Verify number of favorite tracks from test account
            propertyArray = [[SCMe sharedMe].subresources objectForKey:@"favorites"];
            numFavs = [propertyArray count];
            if(numFavs != 2) {
                NSLog(@"Table isn't updated with added fav track.");
            }
        });
    }
}

/* Note: I only performed checks for favourites becuase favourites and tracks extend the same SCTrackTableBaseViewController, so the test case is redundant.*/

@end
