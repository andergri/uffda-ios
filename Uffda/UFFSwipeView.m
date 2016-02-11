//
//  UFFSwipeView.m
//  Uffda
//
//  Created by Griffin Anderson on 10/30/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFSwipeView.h"
#import "QuartzCore/QuartzCore.h"

#define backgroundContentColorDefualt [UIColor colorWithRed:0 green:0 blue:0 alpha:.02]
#define backgroundContentColorDefualtStroke [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
#define backgroundContentColorPositive [UIColor greenColor]
#define backgroundContentColorNegative [UIColor redColor]
#define backgroundContentColorShare [UIColor colorWithRed:(102.0/255.0) green:(91.0/255.0) blue:(171.0/255.0) alpha:1]
#define backgroundContentColorFriend [UIColor yellowColor]
#define backgroundContentColorInvite [UIColor yellowColor]

@interface UFFSwipeView()

    @property (strong, nonatomic) IBOutlet UIView *contentView;
    @property (strong, nonatomic) UIColor* backgroundContainerColor;

@end

@implementation UFFSwipeView

@synthesize backgroundContainerColor;

-(void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"UFFSwipeView" owner:self options:nil];
    [self addSubview: self.contentView];
    [self setBackgroundColor:[UIColor clearColor]];
    self.backgroundContainerColor = backgroundContentColorDefualt;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, self.backgroundContainerColor.CGColor);
    CGContextSetAlpha(context, 0.5);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
    
    CGContextSetStrokeColorWithColor(context, self.backgroundContainerColor.CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));

}

- (void)changeContentBackgroundDefualt {
    self.backgroundContainerColor = backgroundContentColorDefualt;
    [self setNeedsDisplay];
}
- (void)changeContentBackgroundPositive {
    self.backgroundContainerColor = backgroundContentColorPositive;
    [self setNeedsDisplay];
}
- (void)changeContentBackgroundNegative {
    self.backgroundContainerColor = backgroundContentColorNegative;
    [self setNeedsDisplay];
}
- (void)changeContentBackgroundShare{
    self.backgroundContainerColor = backgroundContentColorShare;
    [self setNeedsDisplay];
}
- (void)changeContentBackgroundFriend{
    self.backgroundContainerColor = backgroundContentColorFriend;
    [self setNeedsDisplay];
}
- (void)changeContentBackgroundInvite{
    self.backgroundContainerColor = backgroundContentColorInvite;
    [self setNeedsDisplay];
}



@end
