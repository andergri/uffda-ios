//
//  UFFConstants.m
//  Uffda
//
//  Created by Griffin Anderson on 11/6/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFConstants.h"

#pragma mark - NSObject User Class
// Class key
NSString *const kUFFUserClassKey        = @"user";
// Field keys
NSString *const kUFFUserIDKey         = @"userID";
NSString *const kUFFUserUsernameKey    = @"userUsername";
NSString *const kUFFUserFullNameKey    = @"userFullName";
NSString *const kUFFUserThumbnailKey   = @"userThumbnail";
// Field keys
NSString *const kUFFUserSharedSharedKey     =@"shared";
NSString *const kUFFUserSharedPassKey       =@"passed";
NSString *const kUFFUserSharedNullKey       =@"";

#pragma mark - NSObject Category Class
// Class key
NSString *const kUFFCatgeoryClassKey        = @"Category";
// Field keys
NSString *const kUFFCategoryIDKey           = @"categoryID";
NSString *const kUFFCategoryNameKey         = @"categoryName";
NSString *const kUFFCategoryThumbnailKey    = @"categoryThumbnail";
NSString *const kUFFCategoryBackgroundKey   = @"categoryBackground";
NSString *const kUFFCategoryNetworkKey      = @"categoryNetwork";
NSString *const kUFFCategoryPathKey         = @"categoryPath";
NSString *const kUFFCategoryAPIKey          = @"categoryAPI";
NSString *const kUFFCategoryActiveKey       = @"categoryActive";


#pragma mark - NSObject Media Class
// Class key
NSString *const kUFFMediaClassKey       = @"Media";
// Field keys
NSString *const kUFFMediaIDKey              = @"mediaID";
NSString *const kUFFMediaTypeKey            = @"mediaType";
NSString *const kUFFMediaTitleKey           = @"mediaTitle";
NSString *const kUFFMediaSubtitleKey        = @"mediaSubtitle";
NSString *const kUFFMediaAttributionKey     = @"mediaAttribution";
NSString *const kUFFMediaPublishedKey       = @"mediaPublished";
NSString *const kUFFMediaDomainKey          = @"mediaDomain";
NSString *const kUFFMediaLinkKey            = @"mediaLink";
NSString *const kUFFMediaImageKey           = @"mediaImage";
NSString *const kUFFMediaVisualContentKey   = @"mediaVisualContnet";
NSString *const kUFFMediaPlayableContentKey = @"mediaPlayableContent";
NSString *const kUFFMediaReadableContentKey = @"mediaReadableContent";
// Media Type Keys
NSString *const kUFFMediaTypeURLKey      = @"url";
NSString *const kUFFMediaTypeVideoKey    = @"video";
NSString *const kUFFMediaTypeImageKey    = @"image";
NSString *const kUFFMediaTypeArticleKey  = @"article";
NSString *const kUFFMediaTypeSoundKey    = @"sound";
NSString *const kUFFMediaTypeProductKey  = @"product";


#pragma mark - NSObject Relationship Class
// Class key
NSString *const kUFFRelationshipClassKey        = @"Relationship";
// Field keys
NSString *const kUFFRelationshipIDKey           = @"relationshipID";
NSString *const kUFFRelationshipInitiatorKey    = @"relationshipInitiator";
NSString *const kUFFRelationshipReceiverKey     = @"relationshipReceiver";
NSString *const kUFFRelationshipStatusTypeKey   = @"relationshipStatusType";
// Relationship Keys
NSString *const kUFFRelationshipActionRequestedKey   = @"requested";
NSString *const kUFFRelationshipActionFriendsKey     = @"friends";
NSString *const kUFFRelationshipActionBlockedKey     = @"blocked";
// Relationship Views
NSString *const kUFFRelationshipNewFriendAdd         = @"Add";
NSString *const kUFFRelationshipNewFriendAccept      = @"Accept";
NSString *const kUFFRelationshipNewFriendBlock       = @"block";
NSString *const kUFFRelationshipNewFriendRequested   = @"Requested";
NSString *const kUFFRelationshipNewFriendUnfriend    = @"Unfriend";
NSString *const kUFFRelationshipNewFriendUnblock     = @"Unblock";
NSString *const kUFFRelationshipNewFriendBlocked     = @"Blocked";


#pragma mark - NSObject Action Class
// Class key
NSString *const kUFFActionClassKey      = @"action";
// Field keys
NSString *const kUFFActionIDKey         = @"actionID";
NSString *const kUFFActionUserKey       = @"actionUser";
NSString *const kUFFActionMediaKey      = @"actionMedia";
NSString *const kUFFActionLikedKey      = @"actionLiked";

#pragma mark - NSObject Share Class
// Class key
NSString *const kUFFShareClassKey       = @"Share";
// Field keys
NSString *const kUFFShareIDKey          = @"shareID";
NSString *const kUFFShareToKey          = @"shareTo";
NSString *const kUFFShareFromKey        = @"shareFrom";
NSString *const kUFFShareMediaKey       = @"shareMedia";
NSString *const kUFFShareCommentKey     = @"shareComment";
NSString *const KUFFShareLikedKey       = @"shareLiked";
NSString *const kUFFShareVisitedKey     = @"shareVisited";

#pragma mark - NSObject SharePlatform Class
// Class key
NSString *const kUFFSharePlatformClassKey       = @"Shareplatfrom";
// Field keys
NSString *const kUFFSharePlatformIDKey              = @"sharePlatfromID";
NSString *const kUFFSharePlatformTypeKey            = @"sharePlatfromType";
NSString *const kUFFSharePlatformContactNameKey     = @"sharePlatfromContactName";
NSString *const kUFFSharePlatformContactDetailsKey  = @"sharePlatfromContactDetails";
NSString *const kUFFSharePlatformFromKey            = @"sharePlatfromFrom";
NSString *const kUFFSharePlatformMediaKey           = @"sharePlatfromMedia";
NSString *const kUFFSharePlatformCommentKey         = @"sharePlatfromComment";
NSString *const kUFFSharePlatformShortURLKey        = @"sharePlatfromShortURL";
// To Keys
NSString *const kUFFSharePlatformTypeMessageKey   = @"message";
NSString *const kUFFSharePlatformTypeEmailKey     = @"email";
NSString *const kUFFSharePlatformTypeFacebookKey  = @"facebook";
NSString *const kUFFSharePlatformTypeTwitterKey   = @"twitter";
NSString *const kUFFSharePlatformTypeInstagramKey = @"instagram";
NSString *const kUFFSharePlatformTypeMessageSentKey   = @"messageSent";


#pragma mark - Cache
NSString *const kUFFCacheFriendsFriendsKey           = @"cacheFriends";
NSString *const kUFFCacheShareInboxKey               = @"cacheInboxDate";
NSString *const kUFFCacheRelationshipRequestsKey     = @"cacheRelationshipRequests";

#pragma mark - NetworkClient
//Parse
NSString *const kUFFParseNetworkApplicationIDKey    =@"2WQkKlufhKEO5l3HxrK1BzzfItkIEgaxlCHskSr7";
NSString *const kUFFParseNetworkClientKeyKey        =@"O8yF4RPvrIoQeKkIA00wtL7nKHqVyWmC9OGnI2Xb";

//Kimono
NSString *const kUFFKimonoNetworkTitleKey       = @"Kimono";
NSString *const kUFFKimonoNetworkBaseURLKey     = @"https://www.kimonolabs.com";

// 500px
NSString *const kUFF500pxNetworkTitleKey        = @"500px";
NSString *const kUFF500pxNetworkBaseURLKey      = @"https://api.500px.com";

//Instagram
NSString *const kUFFInstagramNetworkTitleKey        = @"Instagram";
NSString *const kUFFInstagramNetworkAPIKey          = @"349aa0b75d864abebbad7721fef4e947";
NSString *const kUFFInstagramNetworkBaseURLKey      = @"https://api.instagram.com";
NSString *const kUFFInstagramNetworkGetSelfPathKey          = @"/v1/users/self";
NSString *const kUFFInstagramNetworkGetFriendsPathKey      = @"/v1/users/self/follows";
NSString *const kUFFInstagramNetworkAuthPathKey            = @"/oauth/authorize/";
NSString *const kUFFInstagramNetworkTokenPathKey           = @"/oauth/access_token/";
NSString *const kUFFInstagramNetworkRedirectUriKey         = @"uffda://auth/instagram/";

//SoundCloud
NSString *const kUFFSoundCloudNetworkTitleKey        =@"SoundCloud";
NSString *const kUFFSoundCloudNetworkBaseURLKey      =@"https://api.soundcloud.com";
NSString *const kUFFSoundCloudNetworkAPIKey          =@"22243eb582c959dc587009ad0e8f2a5a";

//Espn
NSString *const kUFFEspnNetworkTitleKey              =@"Espn";
NSString *const kUFFEspnNetworkBaseURLKey            =@"http://api.espn.com";

//Etsy
NSString *const kUFFEtsyNetworkTitleKey                 =@"Etsy";
NSString *const kUFFEtsyNetworkBaseURLKey               =@"https://openapi.etsy.com";

// NYTimes
NSString *const kUFFNYTimesNetworkTitleKey          = @"New York Times";
NSString *const kUFFNYTimesNetworkBaseURLKey        = @"http://api.nytimes.com";

// Youtube
NSString *const kUFFYoutubeNetworkTitleKey       =@"YouTube";
NSString *const kUFFYoutubeNetworkBaseURLKey     =@"https://www.googleapis.com";

// Ios Photos
NSString *const kUFFIosPhotosNetworkTitleKey        =@"Photo";