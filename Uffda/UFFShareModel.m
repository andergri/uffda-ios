//
//  UFFShareModel.m
//  Uffda
//
//  Created by Griffin Anderson on 11/19/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFShareModel.h"
#import "UFFMediaModel.h"
#import "UFFUserModel.h"
#import <Parse/Parse.h>


@implementation UFFShareModel

@dynamic visited;
@dynamic createdAt;
@dynamic comment;
@dynamic liked;
@dynamic objectId;
@dynamic to;
@dynamic from;
@dynamic media;


// NSCoding Save for later
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.objectId        forKey:kUFFShareIDKey];
    [aCoder encodeObject:self.to        forKey:kUFFShareToKey];
    [aCoder encodeObject:self.from      forKey:kUFFShareFromKey];
    [aCoder encodeObject:self.media     forKey:kUFFShareMediaKey];
    [aCoder encodeObject:self.visited   forKey:kUFFShareVisitedKey];
    [aCoder encodeObject:self.comment   forKey:kUFFShareCommentKey];
    [aCoder encodeObject:self.liked     forKey:KUFFShareLikedKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        self.objectId =       [aDecoder decodeObjectForKey:kUFFShareIDKey];
        self.to =       [aDecoder decodeObjectForKey:kUFFShareToKey];
        self.from =     [aDecoder decodeObjectForKey:kUFFShareFromKey];
        self.media =    [aDecoder decodeObjectForKey:kUFFShareMediaKey];
        self.visited =  [aDecoder decodeObjectForKey:kUFFShareVisitedKey];
        self.comment =  [aDecoder decodeObjectForKey:kUFFShareCommentKey];
        self.liked =    [aDecoder decodeObjectForKey:KUFFShareLikedKey];
    }
    return self;
}


@end
