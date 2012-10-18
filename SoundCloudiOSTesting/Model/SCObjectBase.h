//
//  SCObjectBase.h
//  SoundCloudiOSTesting
//
//  Created by SoundCloud on 12/03/2012.
//  Copyright (c) 2012 SoundCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @class Base class for model objects.
 Complies to NSCoding and provides convenience
 constructors for initalizing from JSON
 */

@interface SCObjectBase : NSObject <NSCoding>

+ (id) objectWithDictionary:(NSDictionary*)dict;
- (id) initWithDictionary:(NSDictionary*)dict;

@end
