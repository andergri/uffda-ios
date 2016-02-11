//
//  UFFURLShortner.h
//  Uffda
//
//  Created by Griffin Anderson on 4/7/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFFURLShortner : NSObject

+ (void) shortenURL:(NSString *)url  block:(void (^)(BOOL succeeded, NSString* shortUrl))completionBlock;

+ (NSString*) shortenURL:(NSString *)url;
@end
