//
//  SCObjectBase.m
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import "SCObjectBase.h"

@implementation SCObjectBase

+ (id) objectWithDictionary:(NSDictionary*)dict {
  return [[[self class] alloc] initWithDictionary:dict];
}

- (id) initWithDictionary:(NSDictionary*)dict {
  return [super init];  
}

- (void)encodeWithCoder:(NSCoder *)encoder {}

- (id)initWithCoder:(NSCoder *)decoder {
  return [super init];
}

- (void) dealloc {
  // cancels any block dispatches
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
