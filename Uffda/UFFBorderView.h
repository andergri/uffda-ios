//
//  UFFBorderView.h
//  Uffda
//
//  Created by Griffin Anderson on 11/23/13.
//  Copyright (c) 2013 Griffin Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UFFBorderView : UIView

- (void)changeArcBackgroundClear;
- (void)changeArcbackgroundToCloseUp;
- (void)changeArcBackgroundShareCenterDegree:(NSNumber *) degree distance:(NSNumber *) distance fill:(bool) fill ;
- (void)changeArcBackgroundFriendCenterDegree:(NSNumber *) degree distance:(NSNumber *) distance fill:(bool) fill ;
- (void)changeArcBackgroundInviteCenterDegree:(NSNumber *) degree distance:(NSNumber *) distance fill:(bool) fill ;
- (void)changeArcBackgroundFromShareCenterDegree:(NSNumber *) degree distance:(NSNumber *) distance fill:(bool) fill ;

@property CGFloat lineWidth;
@property CGFloat frameOffset;
@end
