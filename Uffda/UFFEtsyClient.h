//
//  UFFEtsyClient.h
//  Uffda
//
//  Created by Griffin Anderson on 1/29/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFFEtsyClient : AFHTTPSessionManager

+ (UFFEtsyClient *)sharedClient;
- (NSURLSessionDataTask *)getProductByCategoryNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;
@end
