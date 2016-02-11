//
//  UFFBorderView.m
//  Uffda
//
//  Created by Griffin Anderson on 11/23/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import "UFFBorderView.h"
#import "QuartzCore/QuartzCore.h"

#define backgroundBorderColorDefualt [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:.5]

#define backgroundArcColorClear [UIColor clearColor]
#define backgroundArcColorShare [UIColor colorWithRed:(102.0/255.0) green:(91.0/255.0) blue:(171.0/255.0) alpha:1]
#define backgroundArcColorFriend [UIColor yellowColor]
#define backgroundArcColorInvite [UIColor yellowColor]
#define backgroundArcColorFromShare [UIColor colorWithRed:(102.0/255.0) green:(91.0/255.0) blue:(171.0/255.0) alpha:1]

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define defualtFrameArcOffset 8
#define defaultLineWidth 10.0

@interface UFFBorderView()

@property (strong, nonatomic) IBOutlet UIView *borderView;
@property (strong, nonatomic) UIColor* backgroundArcColor;
@property NSNumber* arcCenterDegree;
@property NSNumber* arcDistance;
@property BOOL arcFill;
@property BOOL isArc2;


@end

@implementation UFFBorderView

@synthesize backgroundArcColor;
@synthesize arcCenterDegree;
@synthesize arcDistance;
@synthesize arcFill;
@synthesize lineWidth;
@synthesize frameOffset;
@synthesize isArc2;

-(void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"UFFBorderView" owner:self options:nil];
    [self addSubview: self.borderView];
    [self setBackgroundColor:[UIColor clearColor]];
    
    isArc2 = FALSE;
    backgroundArcColor = backgroundArcColorClear;
    lineWidth = defaultLineWidth;
    frameOffset = defualtFrameArcOffset;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    //CGContextSetFillColorWithColor(context, backgroundBorderColorDefualt.CGColor);
    //CGContextSetAlpha(context, 0.5);
    //CGContextFillEllipseInRect(context, CGRectMake(1,1,self.frame.size.width - 2,self.frame.size.height -2));
    
    if (isArc2) {
        [self drawArch2];
    } else if(backgroundArcColor != backgroundArcColorClear){
        [self drawArch];
    }
   // CGContextSetStrokeColorWithColor(context, self.backgroundContainerColor.CGColor);
   // CGContextStrokeEllipseInRect(context, CGRectMake(0,0,self.frame.size.width,self.frame.size.height));
 
}

- (void)drawArch{
    if (self.arcFill) {
        self.arcDistance = [NSNumber numberWithInt:360];
        self.arcCenterDegree = [NSNumber numberWithInt:0];
    } else {
        // Oppisite degree
        int tempArcCenterDegree = [self cleanBorderDegree:([self.arcCenterDegree intValue] + 180)];
        self.arcCenterDegree = [NSNumber numberWithInt:tempArcCenterDegree];
    }
    
    int startDegree = [self cleanBorderDegree:
                       ([self.arcCenterDegree intValue] - ([self.arcDistance intValue] * 0.0))];
    int endDegree = [self cleanBorderDegree:
                     ([self.arcCenterDegree intValue] + ([self.arcDistance intValue] * 1.0))];
    
    CGMutablePathRef arc = CGPathCreateMutable();
    CGPathAddArc(arc, NULL,
                 (self.frame.size.width * 0.5) , (self.frame.size.height * 0.5),
                 (self.frame.size.width * 0.5) - frameOffset,
                 DEGREES_TO_RADIANS(startDegree),
                 DEGREES_TO_RADIANS(endDegree),
                 NO);//centerPoint.x, centerPoint.y,radius,startAngle,endAngle,
    
    CGPathRef strokedArc =
    CGPathCreateCopyByStrokingPath(arc, NULL,
                                   lineWidth,
                                   kCGLineCapButt,
                                   kCGLineJoinMiter, // the default
                                   10); // 10 is default miter limit
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextAddPath(c, strokedArc);
    CGContextSetFillColorWithColor(c, backgroundArcColor.CGColor);
    CGContextSetStrokeColorWithColor(c, backgroundArcColor.CGColor);
    CGContextDrawPath(c, kCGPathFillStroke);

}

- (void) drawArch2{    
    int radius = (self.frame.size.width * 0.5) - frameOffset;
    
    // First circle
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *remainingLayerPath = ([UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES ]);
    circle.path = remainingLayerPath.CGPath;
    //circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                           //  cornerRadius:radius].CGPath;
    circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius - frameOffset,
                                  CGRectGetMidY(self.frame)-radius - frameOffset);
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = backgroundArcColorShare.CGColor;
    circle.lineWidth = defaultLineWidth + 1;
    circle.name = @"drawCircle";
    [self.layer addSublayer:circle];
   
    // Second Circle
    CAShapeLayer *acircle = [CAShapeLayer layer];
    UIBezierPath *aremainingLayerPath = ([UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES ]);
    acircle.path = aremainingLayerPath.CGPath;

    acircle.position = CGPointMake(CGRectGetMidX(self.frame)-radius - frameOffset,
                                  CGRectGetMidY(self.frame)-radius - frameOffset);
    acircle.fillColor = [UIColor clearColor].CGColor;
    acircle.strokeColor = backgroundArcColorShare.CGColor;
    acircle.lineWidth = defaultLineWidth + 1;
    acircle.name = @"aDrawCircle";
    [self.layer addSublayer:acircle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 0.1; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    [acircle addAnimation:drawAnimation forKey:@"aDrawCircleAnimation"];

}

- (int) cleanBorderDegree:(int)degree{
    if (degree > 360) {
        return degree - 360;
    } else if(degree < 0){
        return degree + 360;
    }else{
        return degree;
    }

}

    /** Configure animation
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 10.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    **/


- (void)changeArcBackgroundClear{
    
    for (CALayer *layer in self.layer.sublayers) {
    if ([layer.name isEqualToString:@"drawCircle"]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:@"aDrawCircle"]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    
    self.backgroundArcColor = backgroundArcColorClear;
    self.arcCenterDegree = 0;
    self.arcDistance = 0;
    self.arcFill = FALSE;
    isArc2 = FALSE;
    [self setNeedsDisplay];
}

- (void)changeArcbackgroundToCloseUp {
    self.backgroundArcColor = backgroundArcColorShare;
    isArc2 = TRUE;
    [self setNeedsDisplay];
}

- (void)changeArcBackgroundShareCenterDegree:(NSNumber *)degree distance:(NSNumber *)distance fill:(bool)fill{
    self.backgroundArcColor = backgroundArcColorShare;
    self.arcCenterDegree = degree;
    self.arcDistance = distance;
    self.arcFill = fill;
    isArc2 = FALSE;
    [self setNeedsDisplay];
}
- (void)changeArcBackgroundFriendCenterDegree:(NSNumber *)degree distance:(NSNumber *)distance fill:(bool)fill{
    self.backgroundArcColor = backgroundArcColorFriend;
    self.arcCenterDegree = degree;
    self.arcDistance = distance;
    self.arcFill = fill;
    isArc2 = FALSE;
    [self setNeedsDisplay];
}
- (void)changeArcBackgroundInviteCenterDegree:(NSNumber *)degree distance:(NSNumber *)distance fill:(bool)fill{
    self.backgroundArcColor = backgroundArcColorInvite;
    self.arcCenterDegree = degree;
    self.arcDistance = distance;
    self.arcFill = fill;
    isArc2 = FALSE;
    [self setNeedsDisplay];
}
- (void)changeArcBackgroundFromShareCenterDegree:(NSNumber *)degree distance:(NSNumber *)distance fill:(bool)fill{
    self.backgroundArcColor = backgroundArcColorFromShare;
    self.arcCenterDegree = degree;
    self.arcDistance = distance;
    self.arcFill = fill;
    isArc2 = FALSE;
    [self setNeedsDisplay];
}

@end
