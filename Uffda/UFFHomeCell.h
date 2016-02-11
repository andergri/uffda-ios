//
//  UFFHomeCell.h
//  Uffda
//
//  Created by Griffin Anderson on 11/30/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UFFCategoryModel.h"

@interface UFFHomeCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong) UFFCategoryModel *category;
@property (assign) NSInteger section;

@end
