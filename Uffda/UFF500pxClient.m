//
//  UFF500pxClient.m
//  Uffda
//
//  Created by Griffin Anderson on 11/8/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFF500pxClient.h"

@implementation UFF500pxClient

+ (UFF500pxClient *)sharedClient {
    static UFF500pxClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:kUFF500pxNetworkBaseURLKey];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{ @"oauth_consumer_key" : @"xHkW9aeTnoYk4k1lUYicCjbKY9VXjYOWxE3OsBt8"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[UFF500pxClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

// page, current_page
// x20 using 50

- (NSURLSessionDataTask *)getPhotosByCategoryNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:(void (^)(NSArray *, NSError *))completion{
    
    //@"only" : category,
    NSURLSessionDataTask *task = [self GET:network.path
                                parameters:@{ @"consumer_key" : network.api,
                                              @"feature" : @"popular",
                                              @"sort" : @"created_at",
                                              @"page" : @"1",
                                              @"rpp"  : @"120",
                                              @"image_size" : [NSArray arrayWithObjects:@"3",@"4",nil],
                                              }
                                  
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
    
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"photos"], nil);
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

- (NSURLSessionDataTask *)searchForPhotosNetwork:(UFFCategoryModel *)network search:(NSString *)search completion:(void (^)(NSArray *, NSError *))completion{
    
    NSURLSessionDataTask *task = [self GET:network.path
                                parameters:@{ @"feature" : @"popular",
                                              }
                                  
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"results"], nil);
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
