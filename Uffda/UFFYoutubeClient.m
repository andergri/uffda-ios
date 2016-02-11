//
//  UFFYoutubeClient.m
//  Uffda
//
//  Created by Griffin Anderson on 1/29/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFYoutubeClient.h"

@implementation UFFYoutubeClient

+ (UFFYoutubeClient *)sharedClient {
    static UFFYoutubeClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:kUFFYoutubeNetworkBaseURLKey];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{ @"oauth_consumer_key" : @"xHkW9aeTnoYk4k1lUYicCjbKY9VXjYOWxE3OsBt8"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[UFFYoutubeClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

// &pageToken, nextPageToken
// x5 unsure, use 30 1- 50

- (NSURLSessionDataTask *) getVideosByCategoryNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:(void (^)(NSArray *, NSError *))completion{
    //NSString *categoryId = [self getCategoryNumber:category];
    //NSLog(@"categoryId %@", categoryId);
    NSURLSessionDataTask *task = [self GET:network.path
                                parameters:@{ @"key" : network.api,
                                              @"videoCategoryId" : @"0",
                                              @"chart"  : @"mostPopular",
                                              @"part" : @"snippet",
                                              @"maxResults" : @"50",
                                              }
                                  
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject[@"items"], nil);
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

- (NSString *) getCategoryNumber:(NSString *) category{

    NSDictionary *dict=@{@"All": @"0",
                         @"Film & Animation": @"1",
                         @"Autos & Vehicles": @"2",
                         @"Music": @"10",
                         @"Pets & Animals": @"15",
                         @"Sports": @"17",
                         @"Short Movies": @"18",
                         @"Travel & Events": @"19",
                         @"Gaming": @"20",
                         @"Videoblogging": @"21",
                         @"People & Blogs": @"22",
                         @"Comedy": @"23",
                         @"Entertainment": @"24",
                         @"News & Politics": @"25",
                         @"Howto & Style": @"26",
                         @"Education": @"27",
                         @"Science & Technology": @"28",
                         @"Nonprofits & Activism": @"29",
                         @"Movies": @"30",
                         @"Anime/Animation": @"31",
                         @"Action/Adventure": @"32",
                         @"Classics": @"33",
                         @"Comedy": @"34",
                         @"Documentary": @"35",
                         @"Drama": @"36",
                         @"Family": @"37",
                         @"Foreign": @"38",
                         @"Horror": @"39",
                         @"Sci-Fi/Fantasy": @"40",
                         @"Thriller": @"41",
                         @"Shorts": @"42",
                         @"Shows": @"43",
                         @"Trailers": @"44",
                         };
    for (NSString *key in dict) {
        if ([key isEqualToString:category]) {
            return [dict valueForKey:key];
        }
    }
    return nil;
}

@end
