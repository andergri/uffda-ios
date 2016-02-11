//
//  UFFInboxCache.m
//  Uffda
//
//  Created by Griffin Anderson on 11/18/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFInboxCache.h"
#import "TMCache.h"
#import "UFFShareModel.h"

@implementation UFFInboxCache

// Cache
+ (void)clear{
    [[TMCache sharedCache] removeAllObjects];
}

// Friends
+ (void)setInboxRefresh{
    NSDate *myDate = [NSDate date];
    [[TMCache sharedCache] setObject:myDate forKey:kUFFCacheShareInboxKey];
}
+ (NSDate *)getInboxRefresh{
    return [[TMCache sharedCache] objectForKey:kUFFCacheShareInboxKey];
}
@end
