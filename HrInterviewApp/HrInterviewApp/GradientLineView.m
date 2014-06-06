//
//  GradientLineView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GradientLineView.h"
#import "Common.h"
#import <QuartzCore/QuartzCore.h>

@implementation GradientLineView

@synthesize direction = _direction;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];    
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupView];
}

- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Replace contents of drawRect with the following:
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *clearColor = [UIColor clearColor]; 
    UIColor *blackColor = [UIColor darkGrayColor];
    
    CGRect paperRect = self.bounds;
    
    if([self.direction isEqualToString:@"up"]){
        drawLinearGradient(context, paperRect, blackColor.CGColor, clearColor.CGColor);
    }else{
        drawLinearGradient(context, paperRect, clearColor.CGColor, blackColor.CGColor);
    }
}


@end
