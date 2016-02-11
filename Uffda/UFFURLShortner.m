//
//  UFFURLShortner.m
//  Uffda
//
//  Created by Griffin Anderson on 4/7/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#include <stdlib.h>
#import "UFFURLShortner.h"

@implementation UFFURLShortner

#define Base 62;

+ (void) shortenURL:(NSString *)url  block:(void (^)(BOOL succeeded, NSString* shortUrl))completionBlock{
    
    NSTimeInterval secondsSinceUnixEpoch = [[NSDate date]timeIntervalSince1970];
   int r = arc4random() % 1000;
    NSString* combined = [NSString stringWithFormat:@"%d%f", r, secondsSinceUnixEpoch];
    long value = [combined longLongValue];
    NSString * shortURL = [self encode:value];
    
    completionBlock(YES, shortURL);
}

+ (NSString*) shortenURL:(NSString *)url{
    
    NSTimeInterval secondsSinceUnixEpoch = [[NSDate date]timeIntervalSince1970];
    int r = arc4random() % 1000;
    NSString* combined = [NSString stringWithFormat:@"%d%f", r, secondsSinceUnixEpoch];
    long value = [combined longLongValue];
    NSString * shortURL = [self encode:value];
    
    return shortURL;
}

+ (NSMutableArray *) getAlphabetArray{
    NSMutableArray *array = [NSMutableArray array];
    NSString *str = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (int i = 0; i < [str length]; i++) {
        NSString *ch = [str substringWithRange:NSMakeRange(i, 1)];
        [array addObject:ch];
    }
    return array;
}

+ (NSString *) encode:(long)i{
    
    NSMutableArray *alpha = [self getAlphabetArray];
    if (i == 0) return [alpha objectAtIndex:0];
    
    NSString* s = @"";
    
    while (i > 0) {
        s = [s stringByAppendingString:alpha[i % 62]];
        i = i / 62;
    }
    return [self reverseString:s];
}

+ (int) decodeString:(NSString *)s{
    int i = 0;
    NSMutableArray *alpha = [self getAlphabetArray];
    
    for (NSInteger charIdx=0; charIdx<s.length; charIdx++) {
        
         NSRange subStrRange = NSMakeRange(charIdx, 1);
        int add = (int) [alpha indexOfObject:[s substringWithRange:subStrRange]];
        i = (i * 64) + add;
    }
    
    return i;
}

+ (NSString *) reverseString:(NSString *)string{
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [string length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[string substringWithRange:subStrRange]];
    }
    return reversedString;
}

@end
