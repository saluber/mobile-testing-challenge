//
//  SCFavouritesViewController.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 11/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCTrackTableBaseViewController.h"
#import "SCTrackTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GTMNSString+HTML.h"
#import "Tests.h"

static NSString *const kSCURLFormat = @"soundcloud:tracks:%@";
static const CGFloat kInactiveAlpha = 0.5;

@interface SCTrackTableBaseViewController ()
- (NSArray*) propertyArray;
- (void) tableViewWasTapped:(id)sender;
@end

@implementation SCTrackTableBaseViewController
@synthesize loadedTrackTableCell=_loadedTrackTableCell;

- (void) awakeFromNib {
    [super awakeFromNib];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // account changed
    [nc addObserver:self
           selector:@selector(accountDidChangeNotification:)
               name:SCSoundCloudAccountDidChangeNotification
             object:nil];
    
    // user info...
    [nc addObserver:self
           selector:@selector(userInformationReceived:)
               name:kSCMeLoadedUserInfoNotification
             object:nil];
    
    // subresources
    [nc addObserver:self
           selector:@selector(subresourceReceived:)
               name:kSCMeLoadedSubresourceNotification
             object:nil];
    
    // beginging state...
    [self accountDidChangeNotification:nil];
    [self userInformationReceived:nil];
    [self subresourceReceived:nil];
}

- (void) subresourceReceived:(NSNotification*)note {
    // got resource for this table?
    NSLog(@"SCTrackTableBaseViewController - subresourceReceived");
    if ([[SCMe sharedMe].subresources objectForKey:[self resourceName]]) {
        NSLog(@"SCTrackTableBaseViewController - my resource received, reload table");
        [self.tableView reloadData];
    }
    
    if ([[self resourceName] isEqualToString:@"favorites"]) {
        // Verify loaded info
        [self testViewController];
        [self testViewDataWithChange];
    }
}

- (void) accountDidChangeNotification:(NSNotification *)note {
    NSLog(@"SCTrackTableBaseViewController - accountDidChangeNotification");
    if (![SCSoundCloud account]) {
        // no account... inactive
        NSLog(@"SCTrackTableBaseViewController - unauthenticated account");
        self.navigationController.view.alpha = kInactiveAlpha;
        self.navigationController.view.userInteractionEnabled = NO;
    }
}

- (void) userInformationReceived:(NSNotification*)note {
    NSLog(@"SCTrackTableBaseViewController - userInformationReceivedNotification");
    [self.tableView reloadData];
    [[SCMe sharedMe] requestSubresourceNamed:[self resourceName]
                                 objectClass:[SCTrack class]];
}

- (void) tableViewWasTapped:(id)sender {
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // stops showing extra separators...
    self.tableView.tableFooterView = [[UIView alloc] init];
  
    self.tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.tableView reloadData];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        NSLog(@" ");
    }
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString*) resourceName {
    NSLog(@"Don't use base class!");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)testViewController {
    // Use inherited class version
    NSLog(@"Don't use base class!");
    [self doesNotRecognizeSelector:_cmd];
}


- (void) testViewDataWithChange {
    // User inherited class version
    NSLog(@"Don't use base class!");
    [self doesNotRecognizeSelector:_cmd];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCTrackTableCell *cell = [tableView dequeueReusableCellWithIdentifier:
                              [SCTrackTableCell reuseIdentifier]];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SCTrackTableCell class])
                                      owner:self
                                    options:nil];
        cell = self.loadedTrackTableCell;
        self.loadedTrackTableCell = nil;
    }
    
    SCTrack *track = [[self propertyArray] objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [track.title gtm_stringByUnescapingFromHTML];
    [cell.waveImageView setImageWithURL:track.waveformURL];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCTrack *track = [[self propertyArray] objectAtIndex:indexPath.row];
    
    NSString *urlString = [NSString stringWithFormat:kSCURLFormat, track.identifier];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else if ([[UIApplication sharedApplication] canOpenURL:track.permalinkUrl]) {
        [[UIApplication sharedApplication] openURL:track.permalinkUrl];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray*) propertyArray {
    return [[SCMe sharedMe].subresources objectForKey:[self resourceName]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger ret = [[self propertyArray] count];
    // now data?
    if (ret) {
        // not dragging on table until there's data...
        self.navigationController.view.userInteractionEnabled = YES;
        // fade in
        [UIView animateWithDuration:0.4 animations:^{
            self.navigationController.view.alpha = 1.0;
        }];
    }
    return ret;
}

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void) tableView:(UITableView *)tableView 
   willDisplayCell:(UITableViewCell *)cell 
 forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    cell.backgroundColor = [UIColor whiteColor];
}

@end
