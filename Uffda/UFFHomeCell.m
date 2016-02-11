//
//  UFFHomeCell.m
//  Uffda
//
//  Created by Griffin Anderson on 11/30/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFHomeCell.h"
#import <QuartzCore/QuartzCore.h>

@interface UFFHomeCell()

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@end

@implementation UFFHomeCell

@synthesize imageView;
@synthesize section;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // make sure we rasterize nicely for retina
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.shouldRasterize = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = nil;
}


@end
