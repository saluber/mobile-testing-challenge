//
//  SCTrack.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCTrack.h"

@interface SCTrack ()
@property (strong, readwrite) NSNumber *identifier;
@property (strong, readwrite) NSString *title;
@property (strong, readwrite) NSURL *waveformURL;
@property (strong, readwrite) NSURL *permalinkUrl;
@end

@implementation SCTrack
@synthesize identifier=_identifier, title=_title, waveformURL=_waveformURL;
@synthesize permalinkUrl=_permalinkUrl;

- (id) initWithDictionary:(NSDictionary *)dict {
  if ((self = [super initWithDictionary:dict])) {
    self.identifier = [dict objectForKey:@"id"];
    self.title = [dict objectForKey:@"title"];
    self.waveformURL = [NSURL URLWithString:[dict objectForKey:@"waveform_url"]];
    self.permalinkUrl = [NSURL URLWithString:[dict objectForKey:@"permalink_url"]];
  }
  return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.identifier forKey:@"id"];
  [aCoder encodeObject:self.title forKey:@"title"];
  [aCoder encodeObject:self.waveformURL forKey:@"waveform_url"];
  [aCoder encodeObject:self.permalinkUrl forKey:@"permalink_url"];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    self.identifier = [aDecoder decodeObjectForKey:@"id"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.waveformURL = [aDecoder decodeObjectForKey:@"waveform_url"];
    self.permalinkUrl = [aDecoder decodeObjectForKey:@"permalink_url"];
  }
  return self;
}

@end
