//
//  UFFEspnClient.m
//  Uffda
//
//  Created by Griffin Anderson on 1/28/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFEspnClient.h"

@implementation UFFEspnClient


+ (UFFEspnClient *)sharedClient {
    static UFFEspnClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:kUFFEspnNetworkBaseURLKey];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{ @"oauth_consumer_key" : @"xHkW9aeTnoYk4k1lUYicCjbKY9VXjYOWxE3OsBt8"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[UFFEspnClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

// &offset, max 8000
// x30 unsure

- (NSURLSessionDataTask *)getNewsBySportNetwork:(UFFCategoryModel *)network cateogry:(NSString *)category page:(NSString *)page completion:(void (^)(NSArray *, NSError *))completion{
    
    NSString * resultsSport;
    
    if ([category isEqualToString:@"All Sports"]) {
        resultsSport = @"";
    } else if ([category rangeOfString:@"-"].location == NSNotFound) {
        resultsSport = category;
    } else {
        NSRange sportRange = NSMakeRange(0 , [category rangeOfString:@"-"].location - 1);
        NSString * sportName = [category substringWithRange:sportRange];
        NSRange leagueRange = NSMakeRange(([category rangeOfString:@"-"].location + 2) , (category.length - ([category rangeOfString:@"-"].location + 2)));
        NSString * leagueName = [category substringWithRange:leagueRange];
        resultsSport = [NSString stringWithFormat:@"%@/%@", sportName, leagueName];
        
    }
    resultsSport = [resultsSport lowercaseString];
    NSString *baseKey = network.path;
    baseKey = [baseKey stringByReplacingOccurrencesOfString:@"[sportName]" withString:@""];
    baseKey = [baseKey stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    baseKey = [baseKey stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    NSURLSessionDataTask *task = [self GET:baseKey
                                parameters:@{ @"apikey" : network.api,
                                              @"limit" : @"250",
                                              }
                                  
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"headlines"], nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
}

@end
