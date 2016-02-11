//
//  UFFNYTimesClient.m
//  Uffda
//
//  Created by Griffin Anderson on 7/9/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFNYTimesClient.h"

@implementation UFFNYTimesClient


+ (UFFNYTimesClient *)sharedClient {    static UFFNYTimesClient *_sharedClient = nil;    static dispatch_once_t onceToken;    dispatch_once(&onceToken, ^{        NSURL *baseURL = [NSURL URLWithString:kUFFNYTimesNetworkBaseURLKey];                NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];        //[config setHTTPAdditionalHeaders:@{ @"oauth_consumer_key" : @"xHkW9aeTnoYk4k1lUYicCjbKY9VXjYOWxE3OsBt8"}];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024                                                          diskCapacity:50 * 1024 * 1024                                                              diskPath:nil];
    [config setURLCache:cache];
    _sharedClient = [[UFFNYTimesClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
});        return _sharedClient;
}

// offset
// x20

- (NSURLSessionDataTask *)getNewsBySectionNetwork:(UFFCategoryModel *)network section:(NSString *)section page:(NSString *)page completion:(void (^)(NSArray *, NSError *))completion{        NSString * newSection = section;
    newSection = [newSection lowercaseString];
    newSection = [newSection stringByReplacingOccurrencesOfString:@" " withString:@"+"];        NSString * url = [network.path stringByReplacingOccurrencesOfString:@"[section]" withString:@"all"];    NSLog(@"url %@", url);    NSURLSessionDataTask *task = [self GET:url                                parameters:@{ @"api-key" : network.api,                                                                                            }                                                                     success:^(NSURLSessionDataTask *task, id responseObject) {                                                                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;                                       if (httpResponse.statusCode == 200) {                                           NSLog(@"Times results %@", responseObject[@"num_results"]);                                           dispatch_async(dispatch_get_main_queue(), ^{
        completion(responseObject[@"results"], nil);
    });
    } else {                                           dispatch_async(dispatch_get_main_queue(), ^{
        completion(nil, nil);
    });                                           NSLog(@"Received: %@", responseObject);                                           NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
    }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {                                                                              dispatch_async(dispatch_get_main_queue(), ^{
        completion(nil, error);
    });
    }];    return task;
}
@end