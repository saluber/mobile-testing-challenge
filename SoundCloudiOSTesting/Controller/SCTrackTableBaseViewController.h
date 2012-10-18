//
//  SCFavouritesViewController.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

@class SCTrackTableCell;

/**
 @class Base view controller for displaying a table of the user's tracks
 */

@interface SCTrackTableBaseViewController : UITableViewController

@property (nonatomic, strong) IBOutlet SCTrackTableCell *loadedTrackTableCell;

/** The Me subresource we want to watch/request for this table */
- (NSString*) resourceName;

@end
