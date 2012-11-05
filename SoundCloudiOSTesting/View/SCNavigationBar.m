//
//  SCNavigationBar.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 13/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SCNavigationBar.h"
#import "SCMe.h"
#import "SCLoadingImageView.h"

@interface SCNavigationBar ()
@property (retain) UIImageView *avatarImageView;
- (void) userInformationReceived:(NSNotification*)note;
@end

@implementation SCNavigationBar
@synthesize avatarImageView=_avatarImageView;

- (void) awakeFromNib {
  [super awakeFromNib];
    
  self.tintColor = [UIColor blackColor];
  
  CGFloat height = self.frame.size.height - 10;
  CGRect rect = CGRectMake(0, 0, height, height);
  
  self.avatarImageView = [[SCLoadingImageView alloc] initWithFrame:rect];
  self.avatarImageView.backgroundColor = [UIColor clearColor];
  self.avatarImageView.layer.cornerRadius = 5;
  self.avatarImageView.layer.masksToBounds = YES;
  self.avatarImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  
  UIBarButtonItem *view = [[UIBarButtonItem alloc] initWithCustomView:self.avatarImageView];
  view.width = height;
  self.topItem.rightBarButtonItem = view;
    
  // user info...
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(userInformationReceived:) 
                                               name:kSCMeLoadedUserInfoNotification 
                                             object:nil];
  // may already have user info by now...
  [self userInformationReceived:nil];
}

- (void) userInformationReceived:(NSNotification*)note {
  [self.avatarImageView cancelCurrentImageLoad];

  // show spinner...
    NSLog(@"SCNavigationBar - userInformationReveived - Update Avatar URL");
  NSURL *url = [[SCMe sharedMe] avatarURL];
  if (url) {
    [self.avatarImageView setImageWithURL:url];
  } else {
    self.avatarImageView.image = nil;
  }
}

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
