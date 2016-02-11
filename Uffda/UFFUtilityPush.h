//
//  UFFUtilityPush.h
//  Uffda
//
//  Created by Griffin Anderson on 3/15/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFFUtilityPush : NSObject

+ (void) setUserInstalation;

+ (void) sendPushNotification: (NSString *)sendToUser;

+ (void) resetBadgeCount:(int)badgeCount;

@end
