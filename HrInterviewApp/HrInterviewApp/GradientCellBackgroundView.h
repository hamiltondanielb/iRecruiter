//
//  GradientCellBackgroundView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface GradientCellBackgroundView : UIView

@property (nonatomic, strong) UIColor *seperatorColor;

- (id)initWithFrame:(CGRect)frame DrawSeperator:(NSNumber *)drawSeperator;

@end
