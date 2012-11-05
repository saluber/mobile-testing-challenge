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

@interface UnitTests : SenTestCase {
@private
    SCAppDelegate *app_delegate;
    SCTabBarController * tab_bar_controller;
    UIView * current_view;
}

@end
