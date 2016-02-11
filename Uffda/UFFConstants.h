//
//  UFFConstants.h
//  Uffda
//
//  Created by Griffin Anderson on 11/6/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSUserDefaults

#pragma mark - Launch URLs

#pragma mark - Installation Class


#pragma mark - NSObject User Class
// Class key
extern NSString *const kUFFUserClassKey;
// Field keys
extern NSString *const kUFFUserIDKey;
extern NSString *const kUFFUserUsernameKey;
extern NSString *const kUFFUserFullNameKey;
extern NSString *const kUFFUserThumbnailKey;
// Field keys
extern NSString *const kUFFUserSharedSharedKey;
extern NSString *const kUFFUserSharedPassKey;
extern NSString *const kUFFUserSharedNullKey;

#pragma mark - NSObject Category Class
// Class key
extern NSString *const kUFFCatgeoryClassKey;
// Field keys
extern NSString *const kUFFCategoryIDKey;
extern NSString *const kUFFCategoryNameKey;
extern NSString *const kUFFCategoryThumbnailKey;
extern NSString *const kUFFCategoryBackgroundKey;
extern NSString *const kUFFCategoryNetworkKey;
extern NSString *const kUFFCategoryPathKey;
extern NSString *const kUFFCategoryAPIKey;
extern NSString *const kUFFCategoryActiveKey;

#pragma mark - UFFUser Profile Class
// Field keys

#pragma mark - NSObject Media Class
// Class key
extern NSString *const kUFFMediaClassKey;
// Field keys
extern NSString *const kUFFMediaIDKey;
extern NSString *const kUFFMediaTypeKey;
extern NSString *const kUFFMediaTitleKey;
extern NSString *const kUFFMediaSubtitleKey;
extern NSString *const kUFFMediaAttributionKey;
extern NSString *const kUFFMediaPublishedKey;
extern NSString *const kUFFMediaDomainKey;
extern NSString *const kUFFMediaLinkKey;
extern NSString *const kUFFMediaImageKey;
extern NSString *const kUFFMediaVisualContentKey;
extern NSString *const kUFFMediaPlayableContentKey;
extern NSString *const kUFFMediaReadableContentKey;
// Media Type Keys
extern NSString *const kUFFMediaTypeURLKey;
extern NSString *const kUFFMediaTypeVideoKey;
extern NSString *const kUFFMediaTypeImageKey;
extern NSString *const kUFFMediaTypeArticleKey;
extern NSString *const kUFFMediaTypeSoundKey;
extern NSString *const kUFFMediaTypeProductKey;

#pragma mark - NSObject Relationship Class
// Class key
extern NSString *const kUFFRelationshipClassKey;
// Field keys
extern NSString *const kUFFRelationshipIDKey;
extern NSString *const kUFFRelationshipInitiatorKey;
extern NSString *const kUFFRelationshipReceiverKey;
extern NSString *const kUFFRelationshipStatusTypeKey;
// Relationship Keys
extern NSString *const kUFFRelationshipActionRequestedKey;
extern NSString *const kUFFRelationshipActionFriendsKey;
extern NSString *const kUFFRelationshipActionBlockedKey;
// Relationship Views
extern NSString *const kUFFRelationshipNewFriendAdd;
extern NSString *const kUFFRelationshipNewFriendAccept;
extern NSString *const kUFFRelationshipNewFriendBlock;
extern NSString *const kUFFRelationshipNewFriendRequested;
extern NSString *const kUFFRelationshipNewFriendUnfriend;
extern NSString *const kUFFRelationshipNewFriendUnblock;
extern NSString *const kUFFRelationshipNewFriendBlocked;


#pragma mark - NSObject Action Class
// Class key
extern NSString *const kUFFActionClassKey;
// Field keys
extern NSString *const kUFFActionIDKey;
extern NSString *const kUFFActionUserKey;
extern NSString *const kUFFActionMediaKey;
extern NSString *const kUFFActionLikedKey;

#pragma mark - NSObject Share Class
// Class key
extern NSString *const kUFFShareClassKey;
// Field keys
extern NSString *const kUFFShareIDKey;
extern NSString *const kUFFShareToKey;
extern NSString *const kUFFShareFromKey;
extern NSString *const kUFFShareMediaKey;
extern NSString *const kUFFShareCommentKey;
extern NSString *const KUFFShareLikedKey;
extern NSString *const kUFFShareVisitedKey;

#pragma mark - NSObject SharePlatform Class
// Class key
extern NSString *const kUFFSharePlatformClassKey;
// Field keys
extern NSString *const kUFFSharePlatformIDKey;
extern NSString *const kUFFSharePlatformTypeKey;
extern NSString *const kUFFSharePlatformContactNameKey;
extern NSString *const kUFFSharePlatformContactDetailsKey;
extern NSString *const kUFFSharePlatformFromKey;
extern NSString *const kUFFSharePlatformMediaKey;
extern NSString *const kUFFSharePlatformCommentKey;
extern NSString *const kUFFSharePlatformShortURLKey;
// To Keys
extern NSString *const kUFFSharePlatformTypeMessageKey;
extern NSString *const kUFFSharePlatformTypeEmailKey;
extern NSString *const kUFFSharePlatformTypeFacebookKey;
extern NSString *const kUFFSharePlatformTypeTwitterKey;
extern NSString *const kUFFSharePlatformTypeInstagramKey;
extern NSString *const kUFFSharePlatformTypeMessageSentKey;

#pragma mark - Cache
extern NSString *const kUFFCacheFriendsFriendsKey;
extern NSString *const kUFFCacheShareInboxKey;
extern NSString *const kUFFCacheRelationshipRequestsKey;

#pragma mark - NetworkClient
//Parse
extern NSString *const kUFFParseNetworkApplicationIDKey;
extern NSString *const kUFFParseNetworkClientKeyKey;
//Kimono
extern NSString *const kUFFKimonoNetworkTitleKey;
extern NSString *const kUFFKimonoNetworkBaseURLKey;
//500px
extern NSString *const kUFF500pxNetworkTitleKey;
extern NSString *const kUFF500pxNetworkBaseURLKey;
//Instagram
extern NSString *const kUFFInstagramNetworkTitleKey;
extern NSString *const kUFFInstagramNetworkAPIKey;
extern NSString *const kUFFInstagramNetworkBaseURLKey;
extern NSString *const kUFFInstagramNetworkGetSelfPathKey;
extern NSString *const kUFFInstagramNetworkGetFriendsPathKey;
extern NSString *const kUFFInstagramNetworkAuthPathKey;
extern NSString *const kUFFInstagramNetworkTokenPathKey;
extern NSString *const kUFFInstagramNetworkRedirectUriKey;
//SoundCloud
extern NSString *const kUFFSoundCloudNetworkTitleKey;
extern NSString *const kUFFSoundCloudNetworkBaseURLKey;
extern NSString *const kUFFSoundCloudNetworkAPIKey;
//Espn
extern NSString *const kUFFEspnNetworkTitleKey;
extern NSString *const kUFFEspnNetworkBaseURLKey;
//Etsy
extern NSString *const kUFFEtsyNetworkTitleKey;
extern NSString *const kUFFEtsyNetworkBaseURLKey;
// NYTimes
extern NSString *const kUFFNYTimesNetworkTitleKey;
extern NSString *const kUFFNYTimesNetworkBaseURLKey;
// Youtube
extern NSString *const kUFFYoutubeNetworkTitleKey;
extern NSString *const kUFFYoutubeNetworkBaseURLKey;
// Ios Photos
extern NSString *const kUFFIosPhotosNetworkTitleKey;