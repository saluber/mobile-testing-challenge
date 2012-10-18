//
//  SCLoadingImageView.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCLoadingImageView.h"

@interface SCLoadingImageView ()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation SCLoadingImageView
@synthesize spinner=_spinner;

- (void) setImage:(UIImage *)image {
  self.contentMode = UIViewContentModeScaleToFill;
  
  if (image) {
    [self.spinner removeFromSuperview];
    self.spinner = nil;
  } else {
    if (!self.spinner) {
      self.spinner = [[UIActivityIndicatorView alloc] 
                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      [self.spinner startAnimating];
      self.spinner.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, 
                                        CGRectGetHeight(self.bounds) / 2);
      [self addSubview:self.spinner];
    }
  }
  
  [super setImage:image];
}

- (void) dealloc {
  [self cancelCurrentImageLoad];
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@implementation SCTrackImageView

- (void) layoutSubviews {
  // spinner in top 25%
  self.spinner.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, 
                                    CGRectGetHeight(self.bounds) / 4);
}

@end
