//
//  UFFKimonoClient.m
//  Uffda
//
//  Created by Griffin Anderson on 7/6/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFKimonoClient.h"

@implementation UFFKimonoClient

+ (UFFKimonoClient *)sharedClient {
    static UFFKimonoClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:kUFFKimonoNetworkBaseURLKey];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{ @"oauth_consumer_key" : @"xHkW9aeTnoYk4k1lUYicCjbKY9VXjYOWxE3OsBt8"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[UFFKimonoClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

// page, current_page
// x20 using 50

- (NSURLSessionDataTask *)getMediaByNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:(void (^)(NSArray *, NSError *))completion {
    
    //@"only" : category,
    NSURLSessionDataTask *task = [self GET:network.path
                                parameters:@{ @"apikey" : network.api
                                              }
                                  
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"results"][@"media"], nil);
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
