//
//  QuestionTableBackgroundView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/11/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "QuestionTableBackgroundView.h"

@implementation QuestionTableBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 
                                             blue:1.0 alpha:1.0]; 
    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 
                                                 blue:230.0/255.0 alpha:1.0];
    
    CGRect paperRect = self.bounds;
    
    //drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGrayColor.CGColor);
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, paperRect);
}

@end
