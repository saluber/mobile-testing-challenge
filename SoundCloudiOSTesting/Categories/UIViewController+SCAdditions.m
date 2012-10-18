//
//  UIViewController+SCAdditions.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "UIViewController+SCAdditions.h"

@implementation UIViewController (SCAdditions)

- (void) accountDidChangeNotification:(NSNotification*) note {}
- (void) didFailToRequestAccessNotification:(NSNotification*) note {}
- (void) userInformationReceived:(NSNotification*)note {}
- (void) subresourceReceived:(NSNotification*)note {}

@end
