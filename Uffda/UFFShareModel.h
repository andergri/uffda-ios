//
//  UFFShareModel.h
//  Uffda
//
//  Created by Griffin Anderson on 11/19/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UFFMediaModel, UFFUserModel;

@interface UFFShareModel : NSManagedObject

@property (nonatomic, retain) NSDate * visited;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * liked;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) UFFUserModel *to;
@property (nonatomic, retain) UFFUserModel *from;
@property (nonatomic, retain) UFFMediaModel *media;

@end
