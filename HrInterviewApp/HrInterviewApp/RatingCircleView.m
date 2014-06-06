//
//  RatingCircleView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/9/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "RatingCircleView.h"

@implementation RatingCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, self.bounds);
    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextFillPath(context);
}

- (UIColor *)circleColor
{
    return _circleColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
