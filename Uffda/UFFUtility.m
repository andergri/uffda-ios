//
//  UFFUtility.m
//  Uffda
//
//  Created by Griffin Anderson on 11/7/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFUtility.h"
#import <Parse/Parse.h>
#import "UFFFriendsCache.h"
#import "UFFInboxCache.h"
#import "UFFRelationshipCache.h"
#import "UFFSerializeManger.h"
#import "UFFUtilityPush.h"
#import "UFFCropImage.h"

@implementation UFFUtility

/**
// Parse Init and Test
PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
[testObject setObject:@"bar" forKey:@"foo"];
[testObject save];
**/

// Share Media
+ (void)shareMediaInBackground:(UFFMediaModel *) media to:(UFFUserModel *)user comment:(NSString *)comment randomID:(NSString *)randomID block:(void (^)(BOOL, NSError *, NSString *, NSString *))completionBlock{
    
     if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
     return;
     }
    
    // Check existing relationships
    PFQuery *queryUserA = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserA whereKey:kUFFRelationshipInitiatorKey equalTo:[PFUser currentUser]];
    [queryUserA whereKey:kUFFRelationshipReceiverKey equalTo:[PFObject objectWithoutDataWithClassName:[PFUser parseClassName] objectId:[user objectId]]];
    
    PFQuery *queryUserB = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserB whereKey:kUFFRelationshipReceiverKey equalTo:[PFUser currentUser]];
    [queryUserB whereKey:kUFFRelationshipInitiatorKey equalTo:[PFObject objectWithoutDataWithClassName:[PFUser parseClassName] objectId:[user objectId]]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[queryUserA,queryUserB]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            NSLog(@"Successfully checked relationship %lu", (unsigned long)users.count);
            if(users.count == 0){
                [self saveRelationshipRequestInBackground:user block:^(BOOL succeeded, NSError *error) {
                    NSLog(@"Successfully saved a new relationship");
                    [self getRelationships:^(BOOL succeeded, NSError *error) {}];
                }];
            }
        }else{
            NSLog(@"shareMediaInBackground Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    // Ok to save
    PFObject *parseShare = [PFObject objectWithClassName:kUFFShareClassKey];
    [parseShare setObject:[PFUser currentUser] forKey:kUFFShareFromKey];
    [parseShare setObject:[PFObject objectWithoutDataWithClassName:[PFUser parseClassName] objectId:[user objectId]] forKey:kUFFShareToKey];
    
    if(media.objectId == nil){
        PFObject *parseMedia = [PFObject objectWithClassName:kUFFMediaClassKey];
        
        media.title != nil ? [parseMedia setObject:media.title forKey:kUFFMediaTitleKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaTitleKey];
        media.subtitle != nil ? [parseMedia setObject:media.subtitle forKey:kUFFMediaSubtitleKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaSubtitleKey];
        media.domain != nil ? [parseMedia setObject:media.domain forKey:kUFFMediaDomainKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaDomainKey];
        media.type != nil ? [parseMedia setObject:media.type forKey:kUFFMediaTypeKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaTypeKey];
        media.link != nil ? [parseMedia setObject:media.link forKey:kUFFMediaLinkKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaLinkKey];
        media.attribution != nil ? [parseMedia setObject:media.attribution forKey:kUFFMediaAttributionKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaAttributionKey];
        media.published != nil ? [parseMedia setObject:media.published forKey:kUFFMediaPublishedKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaPublishedKey];
        media.image != nil ? [parseMedia setObject:media.image forKey:kUFFMediaImageKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaImageKey];
        media.playableContent != nil ? [parseMedia setObject:media.playableContent forKey:kUFFMediaPlayableContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaPlayableContentKey];
        media.readableContent != nil ? [parseMedia setObject:media.readableContent forKey:kUFFMediaReadableContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaReadableContentKey];
        media.visualContent != nil ? [parseMedia setObject:media.visualContent forKey:kUFFMediaVisualContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaVisualContentKey];
       
        [parseShare setObject:parseMedia forKey:kUFFShareMediaKey];
    }else{
        [parseShare setObject:[PFObject objectWithoutDataWithClassName:kUFFMediaClassKey objectId:[media objectId]] forKey:kUFFShareMediaKey];
    }
    
    [parseShare setObject:[NSNull null] forKey:kUFFShareVisitedKey];
    [parseShare setObject:[NSNull null] forKey:KUFFShareLikedKey];
    comment != nil ? [parseShare setObject:comment forKey:kUFFShareCommentKey] : [parseShare setObject:[NSNull null] forKey:kUFFShareCommentKey];

    [parseShare saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionBlock){
            if (!error) {
                completionBlock(TRUE, error, parseShare.objectId, randomID);
            }else{
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                completionBlock(FALSE, error, nil, randomID);
            }
        }else{
        }
    }];
    // send push
    [UFFUtilityPush sendPushNotification:user.objectId];
    [self googleTrack:@"shareMedia"];
}

// other platform shaore
+ (void)sharePlatformMediaInBackground:(UFFMediaModel *) media type:(NSString *)type contactName:(NSString *)contactName contactDetails:(NSString *)contactDetails comment:(NSString *)comment shortURL:(NSString *)shortURL randomID:(NSString *)randomID block:(void (^)(BOOL, NSError *, NSString *, NSString *))completionBlock{
    
    PFObject *parseShare = [PFObject objectWithClassName:kUFFSharePlatformClassKey];
    [parseShare setObject:[PFUser currentUser] forKey:kUFFSharePlatformFromKey];
    [parseShare setObject:type forKey:kUFFSharePlatformTypeKey];
    
    contactName != nil ? [parseShare setObject:contactDetails forKey:kUFFSharePlatformContactDetailsKey] : [parseShare setObject:[NSNull null] forKey:kUFFSharePlatformContactDetailsKey];
    contactDetails != nil ? [parseShare setObject:contactName forKey:kUFFSharePlatformContactNameKey] : [parseShare setObject:[NSNull null] forKey:kUFFSharePlatformContactNameKey];
    
    if(media.objectId == nil){
        PFObject *parseMedia = [PFObject objectWithClassName:kUFFMediaClassKey];
        
        media.title != nil ? [parseMedia setObject:media.title forKey:kUFFMediaTitleKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaTitleKey];
        media.subtitle != nil ? [parseMedia setObject:media.subtitle forKey:kUFFMediaSubtitleKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaSubtitleKey];
        media.domain != nil ? [parseMedia setObject:media.domain forKey:kUFFMediaDomainKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaDomainKey];
        media.type != nil ? [parseMedia setObject:media.type forKey:kUFFMediaTypeKey]: [parseMedia setObject:[NSNull null] forKey:kUFFMediaTypeKey];
        media.link != nil ? [parseMedia setObject:media.link forKey:kUFFMediaLinkKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaLinkKey];
        media.attribution != nil ? [parseMedia setObject:media.attribution forKey:kUFFMediaAttributionKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaAttributionKey];
        media.published != nil ? [parseMedia setObject:media.published forKey:kUFFMediaPublishedKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaPublishedKey];
        media.image != nil ? [parseMedia setObject:media.image forKey:kUFFMediaImageKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaImageKey];
        media.playableContent != nil ? [parseMedia setObject:media.playableContent forKey:kUFFMediaPlayableContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaPlayableContentKey];
        media.readableContent != nil ? [parseMedia setObject:media.readableContent forKey:kUFFMediaReadableContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaReadableContentKey];
        media.visualContent != nil ? [parseMedia setObject:media.visualContent forKey:kUFFMediaVisualContentKey]:[parseMedia setObject:[NSNull null] forKey:kUFFMediaVisualContentKey];
        
        [parseShare setObject:parseMedia forKey:kUFFSharePlatformMediaKey];
    }else{
        [parseShare setObject:[PFObject objectWithoutDataWithClassName:kUFFMediaClassKey objectId:[media objectId]] forKey:kUFFSharePlatformMediaKey];
    }
    
    [parseShare setObject:shortURL forKey:kUFFSharePlatformShortURLKey];
    comment != nil ? [parseShare setObject:comment forKey:kUFFSharePlatformCommentKey] : [parseShare setObject:[NSNull null] forKey:kUFFSharePlatformCommentKey];
    
    
    [parseShare saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionBlock){
            if (!error) {
                completionBlock(TRUE, error, parseShare.objectId, randomID);
            }else{
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                completionBlock(FALSE, error, nil, randomID);
            }
        }else{
        }
    }];
    
    [self googleTrack:@"sharePlatformMedia"];
}

// Update a Share Media
+ (void)updateShareInBackground:(UFFShareModel *)share block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    PFQuery *queryShare = [PFQuery queryWithClassName:kUFFShareClassKey];
    
    [queryShare getObjectInBackgroundWithId:[share objectId] block:^(PFObject *parseRelationship, NSError *error) {
        if (!error) {
            // checks to make sure share is only updated by receiving user
            if ([[[parseRelationship objectForKey:kUFFShareFromKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                NSLog(@"Failed to update share: current user share this");
                return;
            }
            [parseRelationship setObject:[NSDate date] forKey:kUFFShareVisitedKey];
            [UFFCoreDataManger updateShareWithObject:[share objectId] visisted:[NSDate date]];
            [parseRelationship saveEventually:completionBlock];
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self googleTrack:@"updateShare"];
}

+ (void) updateShareWithLikeInBackground:(UFFShareModel *)share block:(void (^)(BOOL, NSError *))completionBlock{
    
    PFQuery *queryShare = [PFQuery queryWithClassName:kUFFShareClassKey];
    
    [queryShare getObjectInBackgroundWithId:[share objectId] block:^(PFObject *parseRelationship, NSError *error) {
        if (!error) {
            // checks to make sure share is only updated by receiving user
            if ([[[parseRelationship objectForKey:kUFFShareFromKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                NSLog(@"Failed to update share: current user share this");
                return;
            }
            [parseRelationship setObject:@"1" forKey:KUFFShareLikedKey];
            [UFFCoreDataManger updateShareWithObject:[share objectId] visisted:[NSDate date]];
            [parseRelationship saveEventually:completionBlock];
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self googleTrack:@"updateShareLike"];
}

+ (void)updateShareWithCommentInBackground:(NSString *)share comment:(NSString *)comment platform:(BOOL)platform block:(void (^)(BOOL, NSError *))completionBlock {
    
    
    PFQuery *queryShare;
    if (platform) {
        queryShare = [PFQuery queryWithClassName:kUFFSharePlatformClassKey];
        NSLog(@"UFFUtility %@ %@ A",share, comment);
    }else{
        queryShare = [PFQuery queryWithClassName:kUFFShareClassKey];
        NSLog(@"UFFUtility %@ %@ B",share, comment);
    }
    [queryShare getObjectInBackgroundWithId:share block:^(PFObject *parseRelationship, NSError *error) {
        if (!error) {
            // checks to make sure share is only updated by receiving user
            if (platform) {
                [parseRelationship setObject:comment forKey:kUFFSharePlatformCommentKey];
            }else{
                [parseRelationship setObject:comment forKey:kUFFShareCommentKey];
            }
            [parseRelationship saveEventually:completionBlock];
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self googleTrack:@"updateShareComment"];
}

// Save an image for media
+ (void)saveImageInBackground:(UIImage *)image userName:(NSString *)userName block:(void (^)(NSString *, NSError *))completionBlock{
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imageName = [NSString stringWithFormat:@"share_%@_%f.png", userName, [[NSDate date] timeIntervalSince1970]];
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    PFObject *userPhoto = [PFObject objectWithClassName:@"photos"];
    userPhoto[@"imageFile"] = imageFile;
    [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionBlock){
            if (!error) {
                completionBlock(imageFile.url, error);
            }else{
                completionBlock(nil, error);
            }
        }else{
        }
    }];
    [self googleTrack:@"saveImage"];
}

#pragma - mark Relationship Methods

// save a relation requests
+ (void)saveRelationshipRequestInBackground:(UFFUserModel *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    NSLog(@"relationship -");
    NSLog(@"relationship %@",user.objectId);
    NSLog(@"relationship %@", [PFUser currentUser]);
   // NSLog(@"relationship %@",);
    
    PFObject *relationship = [PFObject objectWithClassName:kUFFRelationshipClassKey];
    [relationship setObject:[PFUser currentUser] forKey:kUFFRelationshipInitiatorKey];
    [relationship setObject:[PFObject objectWithoutDataWithClassName:[PFUser parseClassName] objectId:[user objectId]] forKey:kUFFRelationshipReceiverKey];
    
    [relationship setObject:kUFFRelationshipActionRequestedKey forKey:kUFFRelationshipStatusTypeKey];
    
    [relationship saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionBlock){
        if (!error) {
            completionBlock(TRUE, error);
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
        }else{
        }
    }];
    [self googleTrack:@"saveRelationshipRequest"];
}

// update a a relationship requets
+ (void)updateRelationshipRequestInBackground:(UFFRelationshipModel*)relationship confirm:(BOOL) confirm block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    if (relationship && [relationship objectId]) {

    PFQuery *queryRelationship = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryRelationship getObjectInBackgroundWithId:[relationship objectId] block:^(PFObject *parseRelationship, NSError *error) {
            if (!error && parseRelationship) {
                if (confirm) {
                    [parseRelationship setObject:kUFFRelationshipActionFriendsKey forKey:kUFFRelationshipStatusTypeKey];
                }else{
                    [parseRelationship setObject:kUFFRelationshipActionBlockedKey forKey:kUFFRelationshipStatusTypeKey];
                }
                [parseRelationship saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if(completionBlock){
                        if (!error) {
                        }else{
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                            completionBlock(FALSE, error);
                        }
                    }
                }];
            }else{
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
    }];
    }
    [self googleTrack:@"updateRelationshipRequest"];
}

// remove a a relationship requets
+ (void)removeRelationshipRequestInBackground:(UFFRelationshipModel *)relationship block:(void (^)(BOOL succeeded, NSError *error))completionBlock{

    if (relationship && [relationship objectId]) {
        
        PFQuery *queryRelationship = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
        [queryRelationship getObjectInBackgroundWithId:[relationship objectId] block:^(PFObject *parseRelationship, NSError *error) {
            if (!error && parseRelationship) {
                [parseRelationship deleteInBackground];
                completionBlock(TRUE, error);
            }else{
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                completionBlock(FALSE, error);
            }
        }];
    }
    [self googleTrack:@"removeRelationshipRequest"];
}

#pragma - mark User Methods

// get all categories
+ (void) getCategories:(void (^)(BOOL, NSError *, NSUInteger))completionBlock{

    PFQuery *query = [PFQuery queryWithClassName:kUFFCatgeoryClassKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *categories, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu categories.", (unsigned long)categories.count);
            [UFFSerializeManger changeParseClassToCategoryModel:categories];
            completionBlock(TRUE, error, categories.count);
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error, 0);
        }
    }];
    [self googleTrack:@"getCategories"];
}

// get all relationships
+ (void) getRelationships:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    PFQuery *queryUserA = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserA whereKey:kUFFRelationshipInitiatorKey equalTo:[PFUser currentUser]];
    
    PFQuery *queryUserB = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserB whereKey:kUFFRelationshipReceiverKey equalTo:[PFUser currentUser]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[queryUserA,queryUserB]];
    [query includeKey:kUFFRelationshipInitiatorKey];
    [query includeKey:kUFFRelationshipReceiverKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *relationships, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu relationships.", (unsigned long)relationships.count);
            [UFFCoreDataManger clearAllRelationships];
            [UFFSerializeManger changeParseClassToRelationshipModel:relationships];
            completionBlock(TRUE, error);
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
    [self googleTrack:@"getRelationships"];
}

/**
// get friend requests
+ (void)getFriendRequestsInBackgroundBlock:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    PFQuery *queryFriendRequests = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryFriendRequests orderByDescending:@"createdAt"];
    [queryFriendRequests whereKey:kUFFRelationshipReceiverKey equalTo:[PFUser currentUser]];
    [queryFriendRequests whereKey:kUFFRelationshipStatusTypeKey equalTo:kUFFRelationshipActionRequestedKey];
    [queryFriendRequests includeKey:kUFFRelationshipInitiatorKey];
    [queryFriendRequests includeKey:kUFFRelationshipReceiverKey];
    [queryFriendRequests findObjectsInBackgroundWithBlock:^(NSArray *pendingRelationships, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d friend requests.", pendingRelationships.count);
            [UFFCoreDataManger clearFriends];
            [UFFSerializeManger changeParseClassToRelationshipModel:pendingRelationships];
            completionBlock(TRUE, error);
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
}

// get users friends
+ (void)getFriendsInBackgroundBlock:(void (^)(BOOL succeeded, NSError *error))completionBlock{

    PFQuery *queryUserA = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserA whereKey:kUFFRelationshipInitiatorKey equalTo:[PFUser currentUser]];
    [queryUserA whereKey:kUFFRelationshipStatusTypeKey equalTo:kUFFRelationshipActionFriendsKey];
    
    PFQuery *queryUserB = [PFQuery queryWithClassName:kUFFRelationshipClassKey];
    [queryUserB whereKey:kUFFRelationshipReceiverKey equalTo:[PFUser currentUser]];
    [queryUserB whereKey:kUFFRelationshipStatusTypeKey equalTo:kUFFRelationshipActionFriendsKey];
    
    PFQuery *queryFriends = [PFQuery orQueryWithSubqueries:@[queryUserA,queryUserB]];
    [queryFriends includeKey:kUFFRelationshipInitiatorKey];
    [queryFriends includeKey:kUFFRelationshipReceiverKey];
    [queryFriends findObjectsInBackgroundWithBlock:^(NSArray *relationships, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d friends.", relationships.count);
            [UFFCoreDataManger clearAllRelationships];
            [UFFSerializeManger changeParseClassToRelationshipModel:relationships];
            completionBlock(TRUE, error);
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
}
**/
// search for users in background
+ (void)searchUsersInBackground:(NSString *)searchTerm block:(void (^)(BOOL, NSError *))completionBlock{
    
    //PFQuery *queryUsers = [PFUser query];
    //[queryUsers whereKey:@"username" notEqualTo:[[PFUser currentUser] username]];
    //[queryUsers whereKey:@"username" containsString:searchTerm];
    
    PFQuery *queryUserA = [PFUser query];
    [queryUserA whereKey:@"username" notEqualTo:[[PFUser currentUser] username]];
    [queryUserA whereKey:@"username" containsString:searchTerm];
    
    PFQuery *queryUserB = [PFUser query];
    [queryUserB whereKey:@"fullname" notEqualTo:[[PFUser currentUser] username]];
    [queryUserB whereKey:@"fullname" containsString:searchTerm];
    
    PFQuery *queryUsers = [PFQuery orQueryWithSubqueries:@[queryUserA,queryUserB]];
    [queryUsers findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu search.", (unsigned long)users.count);
            [UFFSerializeManger changeParseClassToUserModel:users];
            completionBlock(TRUE, error);
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
    [self googleTrack:@"searchUsers"];
}

// get the users inbox
+ (void)getInboxInBackgroundBlock:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    NSDate * now;// = [UFFInboxCache getInboxRefresh];
    NSLog(@"inbox now %@", now);
        
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-5];
    now = [gregorian dateByAddingComponents:offsetComponents toDate:[NSDate date] options:0];
    
    
    PFQuery *queryInbox = [PFQuery queryWithClassName:kUFFShareClassKey];
    [queryInbox whereKey:kUFFShareToKey equalTo:[PFUser currentUser]];
    [queryInbox whereKey:kUFFShareVisitedKey equalTo:[NSNull null]];
    
    PFQuery *queryInboxA = [PFQuery queryWithClassName:kUFFShareClassKey];
    [queryInboxA whereKey:kUFFShareFromKey equalTo:[PFUser currentUser]];
    [queryInboxA whereKey:kUFFShareVisitedKey equalTo:[NSNull null]];
    
    PFQuery *queryInboxC = [PFQuery queryWithClassName:kUFFShareClassKey];
    [queryInboxC whereKey:kUFFShareToKey equalTo:[PFUser currentUser]];
    [queryInboxC whereKey:kUFFShareVisitedKey greaterThan:now];
    
    PFQuery *queryInboxD = [PFQuery queryWithClassName:kUFFShareClassKey];
    [queryInboxD whereKey:kUFFShareFromKey equalTo:[PFUser currentUser]];
    [queryInboxD whereKey:kUFFShareVisitedKey greaterThan:now];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[queryInbox, queryInboxA, queryInboxC, queryInboxD]];
    [query orderByDescending:@"updatedAt"];
    [query includeKey:kUFFShareToKey];
    [query includeKey:kUFFShareFromKey];
    [query includeKey:kUFFShareMediaKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *inboxes, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu inbox.", (unsigned long)inboxes.count);
          //  [UFFCoreDataManger clearAllMedia];
          //  [UFFCoreDataManger clearAllShares];
            [UFFSerializeManger changeParseClassToShareModel:inboxes];
            completionBlock(TRUE, error);
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
    [self googleTrack:@"getInbox"];
}

// get instagram Friens
+ (void)getInstagramFriendsInBackgroundBlock:(NSArray *)instagramIds block:(void (^)(BOOL succeeded, NSError *error))completionBlock{
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"instagramID" containedIn:instagramIds];
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu instagram friens.", (unsigned long)users.count);
            [UFFSerializeManger changeParseClassToUserModel:users];
            completionBlock(TRUE, error);
            
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(FALSE, error);
        }
    }];
    [self googleTrack:@"getInstagramFriends"];
    
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
