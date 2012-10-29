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
}

- (void)tearDown
{
    [super tearDown];
}

/* Model testing */
- (void)testNoArchivedUser
{
}

- (void)testSameUserLoginArchivedUser
{
}

- (void)testDiffUserLoginArchivedUser
{
}

/* Controller/View testing */

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

@end
