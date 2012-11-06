//
//  UnitTests.m
//  UnitTests
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import "UnitTests.h"
#import "SCAppDelegate.h"

@implementation UnitTests

- (void)setUp
{
    // Set up for each test
    [super setUp];
    NSLog(@"%@ setUp", self.name);
    app_delegate = (SCAppDelegate*) [[UIApplication sharedApplication] delegate];
    window = app_delegate.window;
    tab_bar_controller = (UITabBarController*)window.rootViewController;
        
    // Nil semaphores for faking multi-thread support when waiting on notification
    sema_accountchanged = dispatch_semaphore_create(-1);
    sema_failedrequest = dispatch_semaphore_create(-1);
    sema_appactive = dispatch_semaphore_create(-1);
    sema_userinfo = dispatch_semaphore_create(-1);
    sema_subresource = dispatch_semaphore_create(-1);    
        
    // Subscribe to all app notifications to verify behavior
      nc = [NSNotificationCenter defaultCenter];
      // account changed
      [nc addObserver:app_delegate
             selector:@selector(accountDidChangeNotification:)
                 name:SCSoundCloudAccountDidChangeNotification
               object:nil];
        // failed to request SCAccount auth
      [nc  addObserver:app_delegate
              selector:@selector(didFailToRequestAccessNotification:)
                  name:SCSoundCloudDidFailToRequestAccessNotification
                object:nil];
        // application became active
      [nc addObserver:app_delegate
             selector:@selector(UIApplicationDidBecomeActiveNotification:)
                 name:UIApplicationDidBecomeActiveNotification
               object:nil];
    
        // user info loaded
        [nc addObserver:app_delegate
               selector:@selector(userInformationReceived:)
                   name:kSCMeLoadedUserInfoNotification
                 object:nil];

        // subresources recieved
        [nc addObserver:app_delegate
               selector:@selector(subresourceReceived:)
                   name:kSCMeLoadedSubresourceNotification
                 object:nil];

        // beginging state...
        [self accountDidChangeNotification:nil];
        [self didFailToRequestAccessNotification:nil];
        [self UIApplicationDidBecomeActiveNotification:nil];
        [self userInformationReceived:nil];
        [self subresourceReceived:nil];
        
    // Wait for SC account auth and SCMe to be done loading
}

- (void)tearDown
{
    // Revokes account authentication
    [SCSoundCloud removeAccess];
    // Unsubscribes from notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}

/* Model (Loaded Data) Test Cases*/

/* ---------------------------------------------------------*/
// Test Case: testUserLoaded
// Verifies SCMe data loaded correctly from SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
- (void)testUserLoaded
{
    // Verify correct user ID loaded
    NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
    STAssertTrue([actual_id isEqualToNumber:[SCMe sharedMe].identifier], @"Incorrect user ID loaded.");
    
    // Verify correct permalink loaded
    NSString * actual = [[NSString alloc] initWithString:@"scapptest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].permalink], @"Incorrect user permalink loaded.");
    
    // Verify correct username loaded
    actual = [[NSString alloc] initWithString:@"SCAppTest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].username], @"Incorrect username loaded.");
    
    // Verify correct uri loaded
    actual = [[NSString alloc] initWithString:@"https://api.soundcloud.com/users/27614868"];
    NSURL * local = [SCMe sharedMe].uri;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect uri loaded.");
    
    // Verify correct permalinkURL loaded
    actual = [[NSString alloc] initWithString:@"http://soundcloud.com/scapptest"];
    local = [SCMe sharedMe].permalinkURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect permalink URL loaded.");
    
    // Verify correct avatarURL loaded
    actual = [[NSString alloc] initWithString:@"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0"];
    local = [SCMe sharedMe].avatarURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect avatar URL loaded.");
    
}

/* ---------------------------------------------------------*/
// Test Case: testArchivesUserLoaded
// Verifies SCMe data loaded correctly from archived SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
- (void) testArchivesUserLoaded
{
    /* Test cases from testUserLoaded but with archive from previous test*/
    
    // Verify correct user ID loaded
    NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
    STAssertTrue([actual_id isEqualToNumber:[SCMe sharedMe].identifier], @"Incorrect user ID loaded.");
    
    // Verify correct permalink loaded
    NSString * actual = [[NSString alloc] initWithString:@"scapptest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].permalink], @"Incorrect user permalink loaded.");
    
    // Verify correct username loaded
    actual = [[NSString alloc] initWithString:@"SCAppTest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].username], @"Incorrect username loaded.");
    
    // Verify correct uri loaded
    actual = [[NSString alloc] initWithString:@"https://api.soundcloud.com/users/27614868"];
    NSURL * local = [SCMe sharedMe].uri;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect uri loaded.");
    
    // Verify correct permalinkURL loaded
    actual = [[NSString alloc] initWithString:@"http://soundcloud.com/scapptest"];
    local = [SCMe sharedMe].permalinkURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect permalink URL loaded.");
    
    // Verify correct avatarURL loaded
    actual = [[NSString alloc] initWithString:@"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0"];
    local = [SCMe sharedMe].avatarURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect avatar URL loaded.");
    
    // Clear Application's Archives for next test
    [TestHelperFunctions clearArchives];
}

/* ---------------------------------------------------------*/
// Test Case: testNoArchivesUserLoaded
// Verifies SCMe data loaded correctly from online SCSoundCloud Account
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. Verifies local copy of SCAccount data matches actual account data
/* ---------------------------------------------------------*/
- (void)testNoArchiveUserLoaded
{
    /* Test cases from testUserLoaded but with archives cleared at end of prev test*/
    
    // Verify valid SC authentication and user data for Test Account Information
    // Verify correct user ID loaded
    NSNumber * actual_id = [[NSNumber alloc] initWithInt:27614868];
    STAssertTrue([actual_id isEqualToNumber:[SCMe sharedMe].identifier], @"Incorrect user ID loaded.");
    
    // Verify correct permalink loaded
    NSString * actual = [[NSString alloc] initWithString:@"scapptest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].permalink], @"Incorrect user permalink loaded.");
    
    // Verify correct username loaded
    actual = [[NSString alloc] initWithString:@"SCAppTest"];
    STAssertTrue([actual isEqualToString:[SCMe sharedMe].username], @"Incorrect username loaded.");
    
    // Verify correct uri loaded
    actual = [[NSString alloc] initWithString:@"https://api.soundcloud.com/users/27614868"];
    NSURL * local = [SCMe sharedMe].uri;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect uri loaded.");
    
    // Verify correct permalinkURL loaded
    actual = [[NSString alloc] initWithString:@"http://soundcloud.com/scapptest"];
    local = [SCMe sharedMe].permalinkURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect permalink URL loaded.");
    
    // Verify correct avatarURL loaded
    actual = [[NSString alloc] initWithString:@"https://i1.sndcdn.com/avatars-000025899311-wi96tv-large.jpg?f6d22d0"];
    local = [SCMe sharedMe].avatarURL;
    STAssertTrue([actual isEqualToString: local.absoluteString], @"Incorrect avatar URL loaded.");
    
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
- (void)testViewNavigation
{
    // Verify moving btwn PresentedControllers: FavViewController, TracksViewController, YouViewController
    
    // FavViewController is default, verify it!
    NSString * title = [[NSString alloc]initWithString:tab_bar_controller.selectedViewController.title];
    STAssertTrue([title isEqualToString:@"FavNavigationController"], @"Incorrect view loaded! Expected: FavNavigationController, Actual:%@", title);

    // Navigate to TracksViewController
    [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:1]];
    
    // Verify TracksViewController
    title = [[NSString alloc]initWithString:tab_bar_controller.selectedViewController.title];
    STAssertTrue([title isEqualToString:@"TracksNavigationController"],@"Incorrect view loaded! Expected: TracksNavigationController, Actual:%@", title);
   
    // Navigate to YouViewController
    [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:2]];
    
    // Verify YouViewController
    title = [[NSString alloc]initWithString:(tab_bar_controller.selectedViewController.title)];
    NSLog(@"title: %@", title);
    STAssertTrue([title isEqualToString:@"YouNavigationController"], @"Incorrect view loaded! Expected: YouNavigationController, Actual:%@", title);
    
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
- (void)testYouViewController
{
    // Navigate to YouViewController
    [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:2]];
    
    // Get UITableViewController for You view controller
    UINavigationController * vc = [[tab_bar_controller selectedViewController] navigationController];
    SCYouViewController * table_control = (SCYouViewController*) [vc presentedViewController];
    
     // Press logout button
     NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:0];
    [table_control tableView:[table_control tableView] didSelectRowAtIndexPath:index];
    
     // Verify logout
    STAssertNil([SCSoundCloud account], @"Logout didn't revoke account authentication.");
}

/* ---------------------------------------------------------*/
// Test Case: testFavouritesViewController
// Verifies track information loaded and maintained by favorites view
// 1. Uses test hook to force authenticate test SoundCloud account
// 2. SCFavouritesNavigationController is default starting controller
// 3. Loads UITableViewController for Favourites view controller
// 4. Verifies favourites track information with test SoundCloud account
/* ---------------------------------------------------------*/
- (void)testFavouritesViewController
{
    // Navigate to FavoritesViewController
    [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:0]];
    
    // Get SCFavouritesViewController
    UINavigationController * vc = [[tab_bar_controller selectedViewController] navigationController];
    SCFavouritesViewController * table_control = (SCFavouritesViewController*) [vc presentedViewController];
    
    // Verify number of favorite tracks from test account
    NSNumber *num_favs = [[NSNumber alloc] initWithInteger:[table_control tableView:[table_control tableView] numberOfRowsInSection:(0)]];
    NSNumber *expected = [[NSNumber alloc] initWithInteger:2];
    STAssertTrue([num_favs isEqualToNumber:expected], @"Incorrect number of favourites loaded:%@", num_favs);
    
    // Verify tracks loaded match actual account favourite tracks
    NSIndexPath * index = [[NSIndexPath alloc] initWithIndex:0];
    SCTrackTableCell * track = (SCTrackTableCell *)[table_control tableView:[table_control tableView] cellForRowAtIndexPath:index];
    
    // Verify first song information
    NSString* title = track.titleLabel.text;
    STAssertTrue([title isEqualToString:@"Joris Voorn - Sensation Innerspace NYC"], @"Mismatched expected first track title: %@", title);
    
    // Verify second song information
    index = [[NSIndexPath alloc] initWithIndex:1];
    track = (SCTrackTableCell *)[table_control tableView:[table_control tableView] cellForRowAtIndexPath:index];
    title = track.titleLabel.text;
        STAssertTrue([title isEqualToString:@"Digitalism - Zdarlight (Fedde Le Grand & Deniz Koyu Remix) preview"], @"Mismatched expected second track title: %@", title);
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
- (void) testFavouritesViewDataWithChange
{
    // Test hook removes favorite
    [TestHelperFunctions removeFavorite:@"58224511"];
    
    // Navigate to FavoritesViewController
    [tab_bar_controller setSelectedViewController:[tab_bar_controller.viewControllers objectAtIndex:0]];
    // SCFavouritesViewController
    UINavigationController * vc = [[tab_bar_controller selectedViewController] navigationController];
    SCFavouritesViewController * table_control = (SCFavouritesViewController*) [vc presentedViewController];    
    
    // Verify number of favorite tracks from test account
    NSNumber *num_favs = [[NSNumber alloc] initWithInteger:[table_control tableView:[table_control tableView] numberOfRowsInSection:0]];
    NSNumber *expected = [[NSNumber alloc] initWithInteger:1];
    STAssertTrue([num_favs isEqualToNumber:expected], @"Table isn't updated with deleted fav track.");
    
    // Test hook re-adds favorite
    [TestHelperFunctions addFavorite:@"58224511"];
    
    // Verify number of favorite tracks from test account
    num_favs = [[NSNumber alloc] initWithInteger:[table_control tableView:[table_control tableView] numberOfRowsInSection:0]];
    expected = [[NSNumber alloc] initWithInteger:2];
    STAssertTrue([num_favs isEqualToNumber:expected], @"Table isn't updated with added fav track.");
}

/* Note: I only performed checks for favourites becuase favourites and tracks extend the same SCTrackTableBaseViewController, so the test case is redundant.*/

/* Helper notifactions listening for NSNotifications */

- (void) accountDidChangeNotification:(NSNotification *)note {
    // Signal if waiting on this notification
    if (sema_accountchanged) {
        dispatch_semaphore_signal(sema_accountchanged);
    }
}

- (void) didFailToRequestAccessNotification:(NSNotification *)note {
    // Signal if waiting on this notification
    if (sema_failedrequest) {
        dispatch_semaphore_signal(sema_failedrequest);
    }
}

- (void) UIApplicationDidBecomeActiveNotification:(NSNotification *)note {
    // Signal if waiting on this notification
    if (sema_appactive) {
        dispatch_semaphore_signal(sema_appactive);
    }
}

- (void) userInformationReceived:(NSNotification *)note {
    // Signal if waiting on this notification
    if (sema_userinfo) {
        dispatch_semaphore_signal(sema_userinfo);
    }
}

- (void) subresourceReceived:(NSNotification *)note {
    // Signal if waiting on this notification
    if (sema_subresource) {
        dispatch_semaphore_signal(sema_subresource);
    }
}

/* Note: Ended up not using semaphores for unit test suite. I decided to focus on testing the 
   validity of the data loaded and the views displayed, instead of focusing on the details of 
   how these tasks are accomplished in the background */

@end
