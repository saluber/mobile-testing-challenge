//
//  UIViewController+SCAdditions.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SCAdditions)

/**
 @group Stubbed methods for receiving account notifications
 Default implementations do nothing but make it tidier for view
 controllers to override consistently.
 */
//{
- (void) accountDidChangeNotification:(NSNotification*) note;
- (void) didFailToRequestAccessNotification:(NSNotification*) note;
/** Got a new SCMe object */
- (void) userInformationReceived:(NSNotification*)note;
/** Loaded a new subresource */
- (void) subresourceReceived:(NSNotification*)note;
//}

@end
