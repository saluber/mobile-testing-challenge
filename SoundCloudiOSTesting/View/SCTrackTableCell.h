//
//  SCFavouritesTableCell.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 15/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @class Table cell for track listings.
 Title and waveform image with SC-style orange gradients
 */

@interface SCTrackTableCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *waveImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

/** @returns Cell's class name as the reuseIdentifier */
+ (NSString*) reuseIdentifier;

@end
