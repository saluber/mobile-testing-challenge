//
//  SCAppDelegate.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCAppDelegate.h"
#import "SCTabBarController.h"

@implementation SCAppDelegate
@synthesize window, tab_bar_controller;

+ (void) initialize {
  if (self == [SCAppDelegate class]) {
    [SCSoundCloud setClientID:@"21f44c1028db56f97b5619bb716fdc63"
                       secret:@"183f80c3b79644cc345e00b36a12e9f8"
                  redirectURL:[NSURL URLWithString:@"soundcloudiostesting://oauth"]];
    // the class itself observers the SC account,
    // so force it to be initialised here...
    // it's protected with a dispatch_once
    [SCMe initialize];
  }
}

@end
