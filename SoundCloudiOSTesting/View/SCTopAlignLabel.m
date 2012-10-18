//
//  SCTopAlignLabel.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCTopAlignLabel.h"

@implementation SCTopAlignLabel

- (void) setText:(NSString *)text {
  [super setText:text];
  
  // size the label for top vertical alignment
  if (self.text && self.superview) {
    CGRect rect = self.frame;
    rect.size = [self.text sizeWithFont:self.font 
                      constrainedToSize:CGSizeMake(self.superview.frame.size.width, FLT_MAX) 
                          lineBreakMode:UILineBreakModeWordWrap];
    self.frame = rect;
  }
}

@end
