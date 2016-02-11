//
//  UFFNYTimesClient.h
//  Uffda
//
//  Created by Griffin Anderson on 7/9/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFFNYTimesClient : AFHTTPSessionManager

+ (UFFNYTimesClient *)sharedClient;
- (NSURLSessionDataTask *)getNewsBySectionNetwork:(UFFCategoryModel *)network section:(NSString *)section page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;

@end
