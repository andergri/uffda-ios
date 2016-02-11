//
//  UFFUtility.h
//  Uffda
//
//  Created by Griffin Anderson on 11/7/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UFFUserModel.h"
#import "UFFMediaModel.h"
#import "UFFRelationshipModel.h"
#import "UFFShareModel.h"
#import "UFFCategoryModel.h"

@interface UFFUtility : NSObject

#pragma - mark Share Methods
// Share Media
+ (void)shareMediaInBackground:(UFFMediaModel *) media to:(UFFUserModel *)user comment:(NSString *)comment randomID:(NSString *)randomID block:(void (^)(BOOL succeeded, NSError *error, NSString *shareID, NSString *randomID))completionBlock;

+ (void)sharePlatformMediaInBackground:(UFFMediaModel *) media type:(NSString *)type contactName:(NSString *)contactName contactDetails:(NSString *)contactDetails comment:(NSString *)comment shortURL:(NSString *)shortURL randomID:(NSString *)randomID block:(void (^)(BOOL succeeded, NSError *error, NSString *shareID, NSString *randomID))completionBlock;

// Update a Share Media
+ (void)updateShareInBackground:(UFFShareModel *)share block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)updateShareWithLikeInBackground:(UFFShareModel *)share block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)updateShareWithCommentInBackground:(NSString *)share comment:(NSString *)comment platform:(BOOL)platform block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

// Save an image for media
+ (void)saveImageInBackground:(UIImage *)image userName:(NSString *)userName block:(void (^)(NSString* imageFile, NSError *error))completionBlock;


#pragma - mark Relationship Methods
// save a relation requests
+ (void)saveRelationshipRequestInBackground:(UFFUserModel *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
// update a a relationship requets
+ (void)updateRelationshipRequestInBackground:(UFFRelationshipModel *)relationship confirm:(BOOL) confirm block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
// remove a a relationship requets
+ (void)removeRelationshipRequestInBackground:(UFFRelationshipModel *)relationship block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

#pragma - mark User Methods

// get all categories
+ (void) getCategories:(void (^)(BOOL succeeded, NSError *error, NSUInteger count))completionBlock;
// get all relationships
+ (void) getRelationships:(void (^)(BOOL succeeded, NSError *error))completionBlock;
// search for users in background
+ (void)searchUsersInBackground:(NSString *) searchTerm block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
// get the users inbox
+ (void)getInboxInBackgroundBlock:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void)getInstagramFriendsInBackgroundBlock:(NSArray *)instagramIds block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end
