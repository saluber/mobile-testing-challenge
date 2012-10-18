//
//  main.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAppDelegate.h"

void onUncaughtException(NSException* exception);
void onUncaughtException(NSException* exception) {
  NSLog(@"uncaught exception: %@\n%@", exception.description, exception.callStackSymbols);
}

int main(int argc, char *argv[])
{
  NSSetUncaughtExceptionHandler(&onUncaughtException);

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SCAppDelegate class]));
    }
}
