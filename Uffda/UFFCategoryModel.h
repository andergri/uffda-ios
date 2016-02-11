//
//  UFFCategoryModel.h
//  Uffda
//
//  Created by Griffin Anderson on 7/7/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef enum uFFNetworkCategory
{
    // Inbox
    Inbox                   = 0,
    // NYTimes
    NewYorkTimes            = 1,
    // 500px
    FiveHundreadPixels      = 2,
    // Instagram
    InstagramFeed           = 3,
    // Soundcloud
    SoundCloud              = 4,
    // Espn
    Espn                    = 5,
    // Etsy
    Etsy                    = 6,
    // Youtube
    YouTube                 = 7,
    // IOS
    iOSPhoto                = 8,
    // Kimono
    Kimono                  = 9,
    
    //Other Methods
    InstagramPopular        = 10,
    InstagramTag            = 11,
    InstagramLiked          = 12,
    InstagramMy             = 13,
    
} UFFNetworkCategory;

@interface UFFCategoryModel : NSManagedObject

@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * network;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * api;
@property (nonatomic, retain) NSString * active;

+(UFFNetworkCategory) formatNetworkStringToNetworkCategory:(NSString *)network;

/**
 @property UFFNetworkRequests dataSource;
 @property NSString * image;
 @property NSString * aname;
 @property NSString * parent;
 
 +(NSMutableArray *) loadContent;
 +(NSMutableArray *) search:(NSString *) search array:(NSArray *)array;
 +(UFFCategoryModel *) getDefaultCategoryFromOptions:(NSArray *)array;
 **/

@end
