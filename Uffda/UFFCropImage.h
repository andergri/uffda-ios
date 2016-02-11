//
//  UFFCropImage.h
//  Uffda
//
//  Created by Griffin Anderson on 3/19/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFFCropImage : NSObject

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
