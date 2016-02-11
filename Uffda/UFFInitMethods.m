//
//  UFFInitMethods.m
//  Uffda
//
//  Created by Griffin Anderson on 1/23/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFInitMethods.h"
#import "UFFUtility.h"
#import "UFFUtilityPush.h"

@implementation UFFInitMethods

+ (void) initData{
    // Loads relationships
    NSLog(@"Signup Error G");
    
    @try {
        [UFFUtilityPush setUserInstalation];
        NSLog(@"Signup Error H");
        [UFFUtility getRelationships:^(BOOL succeeded, NSError *error) {
        }];
        NSLog(@"Signup Error I");
        // Loads inbox
        [UFFUtility getInboxInBackgroundBlock:^(BOOL succeeded, NSError *error) {
        }];
        NSLog(@"Signup Error J");
    }
    @catch (NSException *exception) {
        NSLog(@"big error update");
    }
    @finally {
    }
    NSLog(@"Signup Error K");
}

@end
