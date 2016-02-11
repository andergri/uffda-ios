//
//  UFFEspnClient.h
//  Uffda
//
//  Created by Griffin Anderson on 1/28/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFFEspnClient : AFHTTPSessionManager

+ (UFFEspnClient *)sharedClient;
- (NSURLSessionDataTask *)getNewsBySportNetwork:(UFFCategoryModel *)network cateogry:(NSString *)category page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;


@end
