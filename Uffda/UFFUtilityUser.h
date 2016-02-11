//
//  UFFUtilityUser.h
//  Uffda
//
//  Created by Griffin Anderson on 11/16/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UFFUserModel.h"

@interface UFFUtilityUser : NSObject

+ (void) logoutCurrentUser;

+ (void) isCurrentUserInBlock:(void (^)(BOOL active))completionBlock;

+ (void) registerNewUser:(NSString *) user name:(NSString *) name email:(NSString *)email password:(NSString *)password image:(UIImage *)image block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void) loginUser:(NSString *)username password:(NSString *)password block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void) resetPasswordWithEmail:(NSString *)email block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void) updateUser:(NSString *) username email:(NSString *)email image:(UIImage *)image block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

+ (void) changeOldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword block:(void (^)(BOOL succeeded, NSError *error))completionBlock;


+ (void) getCurrentUserIDInBlock:(void (^)(BOOL loggedIn, NSString * userId))completionBlock;
+ (void) getCurrentUserInBlock:(void (^)(BOOL loggedIn, UFFUserModel * user))completionBlock;
+ (void) getCurrentUserEmailBlock:(void (^)(BOOL loggedIn, NSString * email))completionBlock;
+ (void) saveInstagramOAuth:(NSString *)instagramOAuth block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end
