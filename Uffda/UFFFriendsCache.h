//
//  UFFFriendsCache.h
//  Uffda
//
//  Created by Griffin Anderson on 11/6/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UFFUserModel.h"
#import "UFFMediaModel.h"

@interface UFFFriendsCache : NSObject

// Cache
+ (void)clear;

// Friends
+ (void)setFriends:(NSArray *)friends;
+ (NSMutableArray *)friends;
+ (void) addFriend: (UFFUserModel *)user;
+ (void) removeFriend: (UFFUserModel *)user;
+ (void) clearFriends;

@end
