//
//  UnitTests.h
//  UnitTests
//
//  Created by Sami Luber on 10/28/12.
//  Copyright (c) 2012 jBsoft. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"
#import "SCTabBarController.h"
#import "TestHelperFunctions.h"
#import "SCTrackTableBaseViewController.h"
#import "SCTrackTableCell.h"
#import "SCFavouritesViewController.h"
#import "SCUserTracksViewController.h"
#import "SCYouViewController.h"

@interface UnitTests : SenTestCase {
@private
    // Access app delegate, view controller, and current view
    SCAppDelegate *app_delegate;
    UITabBarController * tab_bar_controller;
    UIWindow *window;
    
    // Semaphores for faking multi-thread support when waiting on notification
    dispatch_semaphore_t sema_accountchanged;
    dispatch_semaphore_t sema_failedrequest;
    dispatch_semaphore_t sema_appactive;
    dispatch_semaphore_t sema_userinfo;
    dispatch_semaphore_t sema_subresource;
    
    
    // Listen to notifications subscribed to by app views
    NSNotificationCenter *nc;
}

@end
