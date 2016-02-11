//
//  UFFDateFormatter.m
//  Uffda
//
//  Created by Griffin Anderson on 2/20/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFDateFormatter.h"

@implementation UFFDateFormatter

+ (NSString *) formatDate:(NSString *) unformattedDate{
    
    NSDate *date = nil;
    if (unformattedDate.length < 11) {
        date = [NSDate dateWithTimeIntervalSince1970:[unformattedDate intValue]];
    }else{
        if (unformattedDate.length == 24) {
            unformattedDate = [unformattedDate substringToIndex:[unformattedDate length] - 5];
            NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
            [dformat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            date = [dformat dateFromString:unformattedDate];
        }else if([unformattedDate rangeOfString:@"/"].location != NSNotFound){
            unformattedDate = [unformattedDate substringToIndex:[unformattedDate length] - 6];
            NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
            [dformat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            date = [dformat dateFromString:unformattedDate];
        }else{
            NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
            [dformat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssz"];
            date = [dformat dateFromString:unformattedDate];
        }
    }
    if (date != nil) {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                        fromDate:date toDate:[NSDate date] options:0];
    
    if (components.year > 1) {
        return [NSString stringWithFormat:@"%ld years", (long)components.year];
    }else if (components.year > 0) {
        return [NSString stringWithFormat:@"one year"];
    }else if(components.month > 1){
        return [NSString stringWithFormat:@"%ld months", (long)components.month];
    }else if(components.month > 0){
        return [NSString stringWithFormat:@"one month"];
    }else if(components.day > 1){
        return [NSString stringWithFormat:@"%ld days", (long)components.day];
    }else if(components.day > 0){
        return [NSString stringWithFormat:@"one day"];
    }else if(components.hour > 1){
        return [NSString stringWithFormat:@"%ld hours", (long)components.hour];
    }else if(components.hour > 0){
        return [NSString stringWithFormat:@"one hour"];
    }else if(components.minute > 1){
        return [NSString stringWithFormat:@"%ld minutes", (long)components.minute];
    }else if(components.minute > 0){
        return [NSString stringWithFormat:@"one minute"];
    }else if(components.second > 0){
        return [NSString stringWithFormat:@"a few seconds"];
    }else {
        return nil;
    }}
    
    return nil;
}

+ (NSString *) formatDatebyDate:(NSDate *) unformattedDate{
    NSDate *date = unformattedDate;
    if (date != nil) {
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                            fromDate:date toDate:[NSDate date] options:0];
        
        if (components.year > 1) {
            return [NSString stringWithFormat:@"%ld years", (long)components.year];
        }else if (components.year > 0) {
            return [NSString stringWithFormat:@"one year"];
        }else if(components.month > 1){
            return [NSString stringWithFormat:@"%ld months", (long)components.month];
        }else if(components.month > 0){
            return [NSString stringWithFormat:@"one month"];
        }else if(components.day > 1){
            return [NSString stringWithFormat:@"%ld days", (long)components.day];
        }else if(components.day > 0){
            return [NSString stringWithFormat:@"one day"];
        }else if(components.hour > 1){
            return [NSString stringWithFormat:@"%ld hours", (long)components.hour];
        }else if(components.hour > 0){
            return [NSString stringWithFormat:@"one hour"];
        }else if(components.minute > 1){
            return [NSString stringWithFormat:@"%ld minutes", (long)components.minute];
        }else if(components.minute > 0){
            return [NSString stringWithFormat:@"one minute"];
        }else if(components.second > 0){
            return [NSString stringWithFormat:@"a few seconds"];
        }else {
            return nil;
        }
    }
    return nil;
}


+ (NSString *) shortFormatDatebyDate:(NSDate *) unformattedDate{
    NSDate *date = unformattedDate;
    if (date != nil) {
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                            fromDate:date toDate:[NSDate date] options:0];
        
        if (components.year > 0) {
            return [NSString stringWithFormat:@"%ldy", (long)components.year];
        }else if(components.week > 0){
            return [NSString stringWithFormat:@"%ldw", (long)components.week];
        }else if(components.day > 0){
            return [NSString stringWithFormat:@"%ldd", (long)components.day];
        }else if(components.hour > 0){
            return [NSString stringWithFormat:@"%ldh", (long)components.hour];
        }else if(components.minute > 0){
            return [NSString stringWithFormat:@"%ldm", (long)components.minute];
        }else if(components.second > 0){
            return [NSString stringWithFormat:@"%lds", (long)components.second];
        }else {
            return nil;
        }
    }
    return nil;
}


@end
