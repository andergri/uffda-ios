//
//  UFFFriendsCache.m
//  Uffda
//
//  Created by Griffin Anderson on 11/6/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFFriendsCache.h"
#import "TMCache.h"

@implementation UFFFriendsCache

// Cache
+ (void)clear{
    [[TMCache sharedCache] removeAllObjects];
}

// Friends
+ (void)setFriends:(NSArray *)friends{
    [[TMCache sharedCache] setObject:friends forKey:kUFFCacheFriendsFriendsKey];
}
+ (NSMutableArray *)friends{
    NSMutableArray *friends = [[TMCache sharedCache] objectForKey:kUFFCacheFriendsFriendsKey];
    return friends;
}
+ (void)addFriend:(UFFUserModel *)user{
    NSMutableArray *friends = [self friends];
    [friends addObject:user];
    [[TMCache sharedCache] removeObjectForKey:kUFFCacheFriendsFriendsKey];
    [self setFriends:friends];
}
+ (void)removeFriend:(UFFUserModel *)user{
    NSMutableArray *friends = [self friends];
    [friends removeObject:user];
    [[TMCache sharedCache] removeObjectForKey:kUFFCacheFriendsFriendsKey];
    [self setFriends:friends];
}
+ (void)clearFriends{
    [[TMCache sharedCache] removeObjectForKey:kUFFCacheFriendsFriendsKey];
}

@end
