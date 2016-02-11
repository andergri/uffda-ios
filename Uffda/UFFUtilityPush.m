//
//  UFFUtilityPush.m
//  Uffda
//
//  Created by Griffin Anderson on 3/15/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFUtilityPush.h"
#import <Parse/Parse.h>

@implementation UFFUtilityPush

+ (void) setUserInstalation{

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    if (![currentInstallation objectForKey:@"user"]) {
        [currentInstallation setObject:[PFUser currentUser] forKey:@"owner"];
        [currentInstallation saveInBackground];
    }
    [self googleTrack:@"setUserInstalation"];
}

+ (void) sendPushNotification: (NSString *)sendToUser{

    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"objectId" equalTo:sendToUser];
    
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"owner" matchesQuery:userQuery];
    
    PFPush *push = [[PFPush alloc] init];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"New message from %@", [PFUser currentUser].username], @"alert",
                          @"Increment", @"badge",
                          nil];
    [push setQuery:pushQuery];
    [push setData:data];
    [push sendPushInBackground];
    [self googleTrack:@"sendPushNotification"];
}

+ (void) resetBadgeCount:(int)badgeCount{
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    currentInstallation.badge = badgeCount;
    [currentInstallation saveEventually];
    
    [self googleTrack:@"resetBadgeCount"];
}

// google tracking api requests
+ (void) googleTrack:(NSString *)method{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder
                    createEventWithCategory:@"Data"
                    action:@"method"
                    label:method
                    value:nil] build]];
}

@end
