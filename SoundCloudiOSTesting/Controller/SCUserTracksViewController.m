//
//  SCUserTracksViewController.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCUserTracksViewController.h"

@interface SCUserTracksViewController ()
@end

@implementation SCUserTracksViewController

- (NSString*) resourceName { return @"tracks"; }

/** The Test app functions for this table */
- (void)testViewController {}
- (void) testViewDataWithChange {}
/* Note: I only performed checks for favourites becuase favourites and tracks extend the same SCTrackTableBaseViewController, so the test case is redundant.*/

@end
