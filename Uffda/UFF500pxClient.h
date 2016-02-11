//
//  UFF500pxClient.h
//  Uffda
//
//  Created by Griffin Anderson on 11/8/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "UFFCategoryModel.h"

@interface UFF500pxClient : AFHTTPSessionManager

+ (UFF500pxClient *)sharedClient;
- (NSURLSessionDataTask *)getPhotosByCategoryNetwork:(UFFCategoryModel *)network category:(NSString *)category page:(NSString *)page completion:( void (^)(NSArray *results, NSError *error) )completion;
- (NSURLSessionDataTask *)searchForPhotosNetwork:(UFFCategoryModel *)network search:(NSString *)search completion:( void (^)(NSArray *results, NSError *error) )completion;

@end
