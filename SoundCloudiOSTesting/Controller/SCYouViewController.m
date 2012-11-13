//
//  SCYouViewController.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCYouViewController.h"
#import "SCMe.h"
#import "Tests.h"

@interface SCYouViewController ()
@end

@implementation SCYouViewController

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // currently only has log out cell...
    NSLog(@"SCYouViewController - user logged out");
  [SCSoundCloud removeAccess]; 
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  [Tests testYouViewController];
}

- (void) userInformationReceived:(NSNotification *)note {
    NSLog(@"SCYouViewController - userInformationReceivedNotification");
  id title = [SCMe sharedMe].username;
    NSLog(@"SCYouViewController - username: %@", title);
  self.title = ( title != [NSNull null] ) ? title : @"You";
}

- (void) awakeFromNib {
  [super awakeFromNib];
  
  // user info...
  [[NSNotificationCenter defaultCenter] addObserver:self 
         selector:@selector(userInformationReceived:) 
             name:kSCMeLoadedUserInfoNotification 
           object:nil];
  
  // default state...
  [self userInformationReceived:nil];
}

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
