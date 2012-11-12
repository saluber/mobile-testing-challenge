//
//  SCTabBarViewController.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @class App's main view controller.
 Monitors the shared SC account and presents a login view controller
 appropriately
 */

extern NSString *const validUserSession;

@interface SCTabBarController : UITabBarController

// For authenticating account before beginning tests
- (void) showAuthentication;

@end
