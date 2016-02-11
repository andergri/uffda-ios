//
//  UFFKimonoClient.h
//  Uffda
//
//  Created by Griffin Anderson on 7/6/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFFKimonoClient : AFHTTPSessionManager

+ (UFFKimonoClient *)sharedClient;
- (NSURLSessionDataTask *)getMediaByNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;
@end