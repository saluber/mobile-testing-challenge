//
//  SCTabBarViewController.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCTabBarController.h"
#import "SCLoginViewController.h"

@interface SCTabBarController () <UIAlertViewDelegate>
- (void) UIApplicationDidBecomeActiveNotification:(NSNotification*) note;
@end

@implementation SCTabBarController

- (void) showAuthentication {
    NSLog(@"SCTabBarController - showAuthentication");
  if (![SCSoundCloud account]) {
    // reset
    NSLog(@"SCTabBarController - no authenticated account");
    self.selectedIndex = 0;
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
      
      SCLoginViewController *loginViewController;
      loginViewController = [SCLoginViewController
                             loginViewControllerWithPreparedURL:preparedURL
                             completionHandler:^(NSError *error)
                             {
                               if (error.code == -1005 || error.code == 100) {
                                 // user cancelled
                                 NSLog(@"User Cancelled during authentication.");
                                 UIAlertView *alert = \
                                 [[UIAlertView alloc]
                                  initWithTitle:@"Authentication Error"
                                  message:@"Authentication is required to use this app"
                                  delegate:self
                                  cancelButtonTitle:@"Retry"
                                  otherButtonTitles:nil];
                                 [alert show];
                               }
                               else if (error) {
                                   // Other unchecked error occured
                                   NSLog(@"Unchecked error during authentication: %@", [error localizedDescription]);
                               }
                             }];
      [self presentModalViewController:loginViewController
                              animated:YES];
    }];
  }
}

- (void) hideAuthentication {
    NSLog(@"SCTabBarController - hideAuthentication");
  [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) accountDidChangeNotification:(NSNotification*)note {
    NSLog(@"SCTabBarController - accountDidChangeNotification");
  [self showAuthentication];
}

- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  // user cancelled retry
    NSLog(@"SCTabBarController - showAlertView");
  [self showAuthentication];
}

- (void) didFailToRequestAccessNotification:(NSNotification*) note {
  // handled in login completion handler
}

- (void) UIApplicationDidBecomeActiveNotification:(NSNotification*) note {
  // may be necessary to reauthenticate when waking from sleep
    NSLog(@"SCTabBarController - userDidBecomeActiveNotification");
  [self showAuthentication];
}

- (void) awakeFromNib {
  [super awakeFromNib];
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(accountDidChangeNotification:)
             name:SCSoundCloudAccountDidChangeNotification
           object:nil];
  [nc  addObserver:self
          selector:@selector(didFailToRequestAccessNotification:)
              name:SCSoundCloudDidFailToRequestAccessNotification
            object:nil];
  [nc addObserver:self
         selector:@selector(UIApplicationDidBecomeActiveNotification:)
             name:UIApplicationDidBecomeActiveNotification
           object:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}

@end
