//
//  SCTrack.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCObjectBase.h"

/** @class Model class for a SC track */

@interface SCTrack : SCObjectBase

@property (strong, readonly) NSNumber *identifier;
@property (strong, readonly) NSString *title;
@property (strong, readonly) NSURL *waveformURL;
@property (strong, readonly) NSURL *permalinkUrl;

@end
