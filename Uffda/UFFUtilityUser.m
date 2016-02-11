//
//  UFFUtilityUser.m
//  Uffda
//
//  Created by Griffin Anderson on 11/16/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFUtilityUser.h"
#import <Parse/Parse.h>
#import "UFFSerializeManger.h"
#import "UFFUtilityPush.h"

@implementation UFFUtilityUser

+ (void) logoutCurrentUser{
    [PFUser logOut];
}

+ (void) isCurrentUserInBlock:(void (^)(BOOL active))completionBlock{
    PFUser *user = [PFUser currentUser];
    
    NSLog(@"isCurrentUserInBlock %@", user);
    if (completionBlock) {
        if (user!=nil) {
            completionBlock(TRUE);
        }else{
            completionBlock(FALSE);
        }
    }
    [self googleTrack:@"isCurrentUser"];
}

+ (void) registerNewUser:(NSString *) user name:(NSString *) name email:(NSString *)email password:(NSString *)password image:(UIImage *)image block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageName = [NSString stringWithFormat:@"%@.png", user];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    PFObject *userPhoto = [PFObject objectWithClassName:@"photos"];
    userPhoto[@"imageFile"] = imageFile;
    [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            
            PFUser *newUser = [PFUser user];
            newUser.username = user;
            newUser.password = password;
            newUser.email = email;
            newUser[@"fullname"] = name;
            newUser[@"thumbnail"] = imageFile.url;
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (completionBlock) {
                    
                    // set instalation
                    [UFFUtilityPush setUserInstalation];
                    completionBlock(succeeded, error);
                }
            }];
        }else{
            if (completionBlock) {
                completionBlock(succeeded, error);
            }
        }
    }];
    [self googleTrack:@"registerNewUser"];
}

+ (void) loginUser:(NSString *)username password:(NSString *)password block:(void (^)(BOOL succeeded, NSError *error))completionBlock{

    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (completionBlock) {
            if (!error) {
                completionBlock(TRUE, error);
            }else{
                completionBlock(FALSE, error);
            }
        }
    }];
    [self googleTrack:@"loginUser"];
}

+ (void) resetPasswordWithEmail:(NSString *)email block:(void (^)(BOOL, NSError *))completionBlock{
    [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
    }];
    [self googleTrack:@"resetPasswordWithEmail"];
}

+ (void) updateUser:(NSString *) username email:(NSString *)email image:(UIImage *)image block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    if (image != nil) {
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageName = [NSString stringWithFormat:@"%@.png", username];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    PFObject *userPhoto = [PFObject objectWithClassName:@"photos"];
    userPhoto[@"imageFile"] = imageFile;
    [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            
            PFUser *user = [PFUser currentUser];
            if(username != nil) user.username = username;
            if(email != nil) user.email = email;
            user[@"thumbnail"] = imageFile.url;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (completionBlock) {
                    completionBlock(succeeded, error);
                }
            }];
        }else{
            if (completionBlock) {
                completionBlock(succeeded, error);
            }
        }
    }];
    }else{
        PFUser *user = [PFUser currentUser];
        if(username != nil) user.username = username;
        if(email != nil) user.email = email;
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (completionBlock) {
                completionBlock(succeeded, error);
            }
        }];
    }
    [self googleTrack:@"updateUser"];
}

+ (void) changeOldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword  block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    PFUser *user = [PFUser currentUser];
    user.password = newPassword;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
    }];
    [self googleTrack:@"changeOldPassword"];
}

+ (void) getCurrentUserIDInBlock:(void (^)(BOOL loggedIn, NSString * userId))completionBlock{
    PFUser *user = [PFUser currentUser];
    if (completionBlock) {
        if (user!=nil) {
            completionBlock(TRUE, [user objectId]);
        }else{
            completionBlock(FALSE, @"");
        }
    }
    [self googleTrack:@"getCurrentUserID"];
}

+ (void) getCurrentUserInBlock:(void (^)(BOOL loggedIn, UFFUserModel * user))completionBlock{
    PFUser *user = [PFUser currentUser];
    if (completionBlock) {
        if (user!=nil) {
            UFFUserModel *serialUser = [UFFSerializeManger changeParseObjectToUserModel:user];
            completionBlock(TRUE, serialUser);
        }else{
            completionBlock(FALSE, nil);
        }
    }
    [self googleTrack:@"getCurrentUser"];
}

+ (void) getCurrentUserEmailBlock:(void (^)(BOOL loggedIn, NSString * email))completionBlock{
    PFUser *user = [PFUser currentUser];
    if (completionBlock) {
        if (user!=nil) {
            completionBlock(TRUE, user[@"email"]);
        }else{
            completionBlock(FALSE, nil);
        }
    }
    [self googleTrack:@"getCurrentUserEmail"];
}


+ (void) saveInstagramOAuth:(NSString *)instagramOAuth block:(void (^)(BOOL, NSError *))completionBlock{

    NSString *instagramID = @"";
    if ([instagramOAuth rangeOfString:@"."].location != NSNotFound) {
       instagramID = [instagramOAuth substringWithRange:NSMakeRange(0, [instagramOAuth rangeOfString:@"."].location)];
    }
    
    PFUser *user = [PFUser currentUser];
    user[@"instagramOAuth"] = instagramOAuth;
    if (instagramID.length > 0) {
        user[@"instagramID"] = instagramID;
    }
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
    }];
    [self googleTrack:@"saveInstagramOAuth"];
}


// google tracking api requests
+ (void) googleTrack:(NSString *)method{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder
                    createEventWithCategory:@"Data"
                    action:@"method"
                    label:method
                    value:nil] build]];
}
@end
