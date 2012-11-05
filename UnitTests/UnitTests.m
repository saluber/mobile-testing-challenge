//
//  UnitTests.m
//  UnitTests
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import "UnitTests.h"

@implementation UnitTests

- (void)setUp
{
    [super setUp];
    NSLog(@"%@ setUp", self.name);
    app_delegate = [[UIApplication sharedApplication] delegate];
    tab_bar_controller = app_delegate.tab_bar_controller;
    current_view = tab_bar_controller.presentedViewController.view;
    NSLog(@"%@ current view", current_view.description);
}

- (void)tearDown
{
    [super tearDown];
}

/* Model testing */

- (void) testUserInformationLoaded {
    // Force automatic login for test SoundCloud Account
    [self automaticSCAccountLogin];
    STAssertNotNil([SCMe sharedMe], @"SCMe failed to load SCAccount");
}

/*
- (void)testNoArchivedUser
{
}

- (void)testSameUserLoginArchivedUser
{
}

- (void)testDiffUserLoginArchivedUser
{
}
*/
/* Controller/View testing */
/*
- (void)testNotificationResponse
{
}

- (void)testViewNavigation
{
}

- (void)testYouViewController
{
}

- (void)testFavoritesViewController
{
}

- (void)testTracksViewController
{
}
*/

/* Helper Functions */
/* Test hooks for testing app */

// Added as test hook for automatic SoundCloud Account login
- (void) automaticSCAccountLogin {
    [SCSoundCloud requestTestAccess:@"SCAppTest" password:@"SCAppTest23"];
}

// Added as a test hook for adding a song to favorites
- (void) addFavorite: (NSString *) songID {
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
- (void) removeFavorite: (NSString*) songID {
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
- (void) addTrack: (NSDictionary*) songInfo {
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
- (void) removeTrack:(NSString*) songID {
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
- (NSDictionary*) getUserProperties {
    __block NSDictionary* properties = nil;
    NSString *urlString = [NSString stringWithFormat:
                           @"%@me.json", kSCSoundCloudAPIURL];
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
                         NSLog(@"Error occured during me request: %@", [error localizedDescription]);
                     }
                     properties = [data objectFromJSONData];
                 }];
    }
    return properties;
}

// Added as a test hook for getting user subresource
- (NSArray *) getSubresource: (NSString*) subresourceName {
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
