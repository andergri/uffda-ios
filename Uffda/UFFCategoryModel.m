//
//  UFFCategoryModel.m
//  Uffda
//
//  Created by Griffin Anderson on 7/7/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFCategoryModel.h"

@implementation UFFCategoryModel


@dynamic objectId;
@dynamic name;
@dynamic thumbnail;
@dynamic background;
@dynamic network;
@dynamic path;
@dynamic api;
@dynamic active;

+(UFFNetworkCategory) formatNetworkStringToNetworkCategory:(NSString *)network{
    
    NSLog(@"FormatNetworkString %@", network);
    
    if (network) {
        
    NSMutableDictionary *categories = [[NSMutableDictionary alloc] init];
	[categories setObject:[NSNumber numberWithInteger:Inbox] forKey:@"Inbox"];
    [categories setObject:[NSNumber numberWithInteger:NewYorkTimes] forKey:@"NewYorkTimes"];
    [categories setObject:[NSNumber numberWithInteger:FiveHundreadPixels] forKey:@"FiveHundreadPixels"];
    [categories setObject:[NSNumber numberWithInteger:InstagramFeed] forKey:@"InstagramFeed"];
    [categories setObject:[NSNumber numberWithInteger:SoundCloud] forKey:@"SoundCloud"];
    [categories setObject:[NSNumber numberWithInteger:Espn] forKey:@"Espn"];
    [categories setObject:[NSNumber numberWithInteger:YouTube] forKey:@"YouTube"];
    [categories setObject:[NSNumber numberWithInteger:Etsy] forKey:@"Etsy"];
    [categories setObject:[NSNumber numberWithInteger:iOSPhoto] forKey:@"iOSPhoto"];
    [categories setObject:[NSNumber numberWithInteger:Kimono] forKey:@"Kimono"];
        
        return (UFFNetworkCategory)[[categories objectForKey:network] intValue];
    }else{
        return Inbox;
    }
}

//[[NSArray arrayWithObjects: @"Uncategorized", @"Abstract", @"Animals", @"Black and White", @"Celebrities", @"City and Architecture", @"Commercial", @"Concert", @"Family", @"Fashion", @"Film", @"Fine Art", @"Food", @"Journalism", @"Landscapes", @"Macro", @"Nature", @"Nude", @"People", @"Performing Arts", @"Sport", @"Still Life", @"Street", @"Transportation", @"Travel", @"Underwater", @"Urban Exploration", @"Wedding", nil]];

/**
 @synthesize dataSource;
 @synthesize image;
 @synthesize aname;
 @synthesize parent;
 
 + (UFFCategoryModel *) createModel:(UFFNetworkRequests)dataSource image:(NSString *)img name:(NSString *)title parent:(NSString *)parents{
 UFFCategoryModel *category = [[UFFCategoryModel alloc] init];
 category.dataSource = dataSource;
 category.image = img;
 category.aname = title;
 category.parent = parents;
 return category;
 }
 
 + (NSMutableArray *) loadContent{
 
 NSMutableArray *array = [[NSMutableArray alloc] init];
 
 // Mailbox
 [array addObject:[self createModel:Inbox image:@"Mailbox.jpg" name:@"" parent:@"Inbox"]];
 
 // Top Level categories
 //   [array addObject:[self createModel:Inbox image:@"Mailbox.jpg"name:@"Inbox" parent:@""]];
 [array addObject:[self createModel:FiveHundreadPixelsPopularCategory image:@"Icon_500px"name:@"500px" parent:@""]];
 [array addObject:[self createModel:SoundCloudGenere image:@"Icon_soundcloud"name:@"SoundCloud" parent:@""]];
 [array addObject:[self createModel:InstagramFeed image:@"Icon_instagram" name:@"Instagram" parent:@""]];
 [array addObject:[self createModel:EspnNews image:@"Icon_espn" name:@"ESPN" parent:@""]];
 [array addObject:[self createModel:NYTimesAll image:@"Icon_nyt" name:@"New York Times" parent:@""]];
 [array addObject:[self createModel:EtsyProduct image:@"Icon_etsy" name:@"Etsy" parent:@""]];
 [array addObject:[self createModel:IosPhotos image:@"Icon_iosphotos" name:@"Photos" parent:@""]];
 [array addObject:[self createModel:KimonoCNN image:@"Icon_youtube" name:@"kYouTube" parent:@""]];
 
 
 // 500px
 NSArray *five = [NSArray arrayWithObjects:@"Uncategorized", @"Abstract", @"Animals", @"Black and White", @"Celebrities", @"City and Architecture", @"Commercial", @"Concert", @"Family", @"Fashion", @"Film", @"Fine Art", @"Food", @"Journalism", @"Landscapes", @"Macro", @"Nature",  @"People", @"Performing Arts", @"Sport", @"Still Life", @"Street", @"Transportation", @"Travel", @"Underwater", @"Urban Exploration", @"Wedding", nil];
 
 for (int i = 0; i < five.count; i++){
 [array addObject:[self createModel:FiveHundreadPixelsPopularCategory image:@"Home_500px" name:five[i] parent:@"500px"]];
 }
 
 // Instagram
 [array addObject:[self createModel:InstagramPopular image:@"Home_instagram" name:@"Popular" parent:@"Instagram"]];
 [array addObject:[self createModel:InstagramFeed image:@"Home_instagram" name:@"My Feed" parent:@"Instagram"]];
 [array addObject:[self createModel:InstagramLiked image:@"Home_instagram" name:@"My Liked" parent:@"Instagram"]];
 [array addObject:[self createModel:InstagramMy image:@"Home_instagram" name:@"My Photos" parent:@"Instagram"]];
 
 NSArray *gram = [NSArray arrayWithObjects:@"instagood",@"me", @"like", @"follow",@"cute",@"photooftheday",@"tbt", @"followme",@"tagsforlikes",@"girl",@"beautiful",@"happy",@"picoftheday",@"instadaily",@"igers",@"fun",@"summer",@"smile",@"like4like",@"friends",@"food",@"swag",@"instalike",@"bestoftheday",@"amazing",@"tflers",@"fashion",@"instamood", @"selfie",@"style",@"webstagram",@"follow4follow",@"iphoneonly",@"lol",@"tweegram",@"all_shots",@"instago",@"pretty",@"l4l",@"my",@"nofilter",@"family",@"instacool",@"life",@"hair",@"instafollow",@"likeforlike",@"eyes",@"sun",@"bored", nil];
 
 for (int i = 0; i < gram.count; i++){
 [array addObject:[self createModel:InstagramTag image:@"Home_instagram" name:gram[i] parent:@"Instagram"]];
 }
 
 // SoundCloud
 NSArray *sound = [NSArray arrayWithObjects:@"Classical", @"Country", @"Dubstep", @"Electronic", @"Hip Hop", @"House", @"Jazz", @"Metal", @"Pop", @"R&B", @"Reggae", @"Rock", @"Techno", @"World", @"Audiobooks", @"Comedy", @"Entertainment", @"Learning", @"News & Politics", @"Religon & Spirituality", @"Science", nil];
 
 for (int i = 0; i < sound.count; i++){
 [array addObject:[self createModel:SoundCloudGenere image:@"Home_soundcloud" name:sound[i] parent:@"SoundCloud"]];
 }
 // NYTimes
 NSArray *times = [NSArray arrayWithObjects:@"All", @"Arts", @"Books", @"Business", @"Business Day",  @"Fashion & Style", @"Great Homes and Destinations", @"Health", @"Magazine", @"Movies", @"Multimedia/Photos", @"Real Estate", @"Science", @"Sports", @"Technology", @"Theater", @"Travel", @"U.S.", @"World", nil];
 
 for (int i = 0; i < times.count; i++){
 [array addObject:[self createModel:NYTimesAll image:@"Home_nyt" name:times[i] parent:@"New York Times"]];
 }
 
 // Espn
 NSArray *espn = [NSArray arrayWithObjects:@"All Sports", @"Baseball", @"Baseball - MLB", @"Baseball - College Baseball", @"Basketball - NBA", @"Basketball - WNBA", @"Basketball - Mens College Basketball", @"Basketball - Womens College Basketball", @"Boxing", @"Football", @"Football - NFL", @"Football - College Football", @"Golf", @"Hockey", @"Hockey - NHL", @"Horse Racing", @"MMA", @"Olympics", @"Racing", @"Soccer", @"Tennis", @"X Games", nil];
 
 for (int i = 0; i < espn.count; i++){
 [array addObject:[self createModel:EspnNews image:@"Home_espn" name:espn[i] parent:@"ESPN"]];
 }
 
 // Etsy
 NSArray *etsy = [NSArray arrayWithObjects: @"Accessories",@"Art",@"Bags and Purses",@"Bath and Beauty", @"Books and zines",@"Candles", @"Ceramics and Pottery", @"Children",@"Clothing",@"Crochet", @"Dolls and Miniatures",@"Everything Else", @"Furniture",@"Geekery",@"Glass",@"Holidays",@"Housewares",@"Jewelry",@"Knitting", @"Music", @"Needlecraft",@"Paper Goods",@"Patterns",@"Pets",@"Plants and Edibles", @"Quilts",@"Supplies", @"Toys",@"Vintage", @"Weddings", @"Woodworking",
 nil];
 
 for (int i = 0; i < etsy.count; i++){
 [array addObject:[self createModel:EtsyProduct image:@"Home_etsy" name:etsy[i] parent:@"Etsy"]];
 }
 
 // Ios photo
 [array addObject:[self createModel:IosPhotos image:@"Home_iosphotos" name:@"" parent:@"Photos"]];
 
 // Youtube
 NSArray *tube = [NSArray arrayWithObjects:@"All", @"Film & Animation", @"Autos & Vehicles", @"Music", @"Pets & Animals",@"Sports", @"Travel & Events",@"Gaming",@"People & Blogs", @"Comedy",@"Entertainment",@"News & Politics",@"Howto & Style",@"Education",@"Science & Technology",@"Nonprofits & Activism", nil];
 
 for (int i = 0; i < tube.count; i++){
 [array addObject:[self createModel:YoutubeVideos image:@"Icon_youtube" name:tube[i] parent:@"YouTube"]];
 }
 
 //Other
 
 return array;
 }
 
 
 
 
 
 + (NSMutableArray *) search:(NSString *)search array:(NSArray *)array{
 
 NSMutableArray *newArray = [[NSMutableArray alloc] init];
 
 for (UFFCategoryModel * category in array) {
 if ([category.parent isEqualToString:search]) {
 [newArray addObject:category];
 }
 }
 return  newArray;
 }
 
 + (UFFCategoryModel *) getDefaultCategoryFromOptions:(NSArray *)array{
 if (array.count > 0) {
 return array[0];
 }else{
 return nil;
 }
 }
 **/
@end

