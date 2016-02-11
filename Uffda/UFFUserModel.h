//
//  UFFUserModel.h
//  Uffda
//
//  Created by Griffin Anderson on 11/19/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
#import "UFFShareModel.h"
#import "UFFRelationshipModel.h"

@interface UFFUserModel : NSManagedObject

@property (nonatomic, retain) NSString * shared;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * instagramOAuth;
@property (nonatomic, retain) NSString * instagramID;
@property (nonatomic, retain) UFFShareModel * tos;
@property (nonatomic, retain) UFFShareModel * froms;
@property (nonatomic, retain) UFFRelationshipModel * initiators;
@property (nonatomic, retain) UFFRelationshipModel * receivers;

@end
