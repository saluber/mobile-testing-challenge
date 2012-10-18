//
//  SCFavouritesTableCell.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 15/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCTrackTableCell.h"
#import "UIColor+SoundCloudUI.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SCTrackTableCell
@synthesize waveImageView=_waveImageView, titleLabel=_titleLabel;

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // observe changes to the waveform image,
  // so that we can adjust the background gradient
  [self.waveImageView addObserver:self 
                       forKeyPath:@"image" 
                          options:NSKeyValueObservingOptionNew 
                          context:NULL];
}

- (void) dealloc {
  [self.waveImageView cancelCurrentImageLoad];  
  [self.waveImageView removeObserver:self forKeyPath:@"image"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath 
                       ofObject:(id)object 
                         change:(NSDictionary *)change 
                        context:(void *)context 
{
  if ([change objectForKey:NSKeyValueChangeNewKey]) {
    // update background colour...
    [self setNeedsDisplay];    
  }
}

- (void) prepareForReuse {
  self.titleLabel.text = nil;
  self.waveImageView.image = nil;
  [self.waveImageView cancelCurrentImageLoad];
  [self setNeedsDisplay];
}

+ (NSString*) reuseIdentifier { return NSStringFromClass(self); }
- (NSString*) reuseIdentifier { return [[self class] reuseIdentifier]; }

- (void) drawRect:(CGRect)rect {
  
  static CGGradientRef gradient = NULL;
  if (gradient == NULL) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[UIColor soundCloudOrangeWithAlpha:1.0].CGColor,
                       (id)[UIColor soundCloudOrangeWithAlpha:0.5].CGColor,
                       nil];
    CGFloat locations[] = { 0.0, 1.0 };
    
    gradient = CGGradientCreateWithColors(colorSpace, 
                                          (__bridge CFArrayRef)colors, 
                                          locations);
    CGColorSpaceRelease(colorSpace);
  }
  
  // draw the gradient only when there's a waveform image...
  if (self.waveImageView.image) {
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), 
                                gradient, 
                                CGPointMake(0, CGRectGetMinY(self.bounds)), 
                                CGPointMake(0, CGRectGetMaxY(self.bounds)), 
                                0);
  }
}

@end
