//
//  UFFYoutubeClient.h
//  Uffda
//
//  Created by Griffin Anderson on 1/29/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFFYoutubeClient : AFHTTPSessionManager

+ (UFFYoutubeClient *)sharedClient;
- (NSURLSessionDataTask *)getVideosByCategoryNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;

@end
