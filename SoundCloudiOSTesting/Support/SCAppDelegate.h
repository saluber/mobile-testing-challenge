//
//  SCAppDelegate.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

/* Enable NSLog only for debug mode or on a simulated device */
#if !defined(DEBUG) || !(TARGET_IPHONE_SIMULATOR)
#define NSLog(...)
#endif

#import <UIKit/UIKit.h>
#import "SCTabBarController.h"

/** @class App delegate for SoundCloudiOSTesting */

@interface SCAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow * window;
    SCTabBarController * tab_bar_controller;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet SCTabBarController * tab_bar_controller;

@end
