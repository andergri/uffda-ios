//
//  UFFInboxCache.h
//  Uffda
//
//  Created by Griffin Anderson on 11/18/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UFFUserModel.h"
#import "UFFMediaModel.h"

@interface UFFInboxCache : NSObject

// Cache
+ (void)clear;

// Friends
+ (void)setInboxRefresh;
+ (NSDate*)getInboxRefresh;

@end
