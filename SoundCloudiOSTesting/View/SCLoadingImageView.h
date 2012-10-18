//
//  SCLoadingImageView.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 16/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

/**
 @class UIImageView that displays an activity indicator
 when the image is nil, and not otherwise
 */ 

@interface SCLoadingImageView : UIImageView
@end

/**
 @class Subclass that expects to have the bottom half of its
 image clipped by the superview. Spinner is repositioned accordingly.
*/

@interface SCTrackImageView : SCLoadingImageView
@end
