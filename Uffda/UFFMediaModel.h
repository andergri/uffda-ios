//
//  UFFMediaModel.h
//  Uffda
//
//  Created by Griffin Anderson on 11/19/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
#import "UFFShareModel.h"


@interface UFFMediaModel : NSManagedObject

@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * attribution;
@property (nonatomic, retain) NSString * published;
@property (nonatomic, retain) NSString * domain;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * visualContent;
@property (nonatomic, retain) NSString * playableContent;
@property (nonatomic, retain) NSString * readableContent;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) UFFShareModel * shares;

#pragma - mark other methods

@end
