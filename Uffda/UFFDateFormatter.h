//
//  UFFDateFormatter.h
//  Uffda
//
//  Created by Griffin Anderson on 2/20/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFFDateFormatter : NSObject

+ (NSString *) formatDate:(NSString *) unformattedDate;
+ (NSString *) formatDatebyDate:(NSDate *) unformattedDate;
+ (NSString *) shortFormatDatebyDate:(NSDate *) unformattedDate;
@end
