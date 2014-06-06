//
//  GradientCellBackgroundView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GradientCellBackgroundView.h"

@implementation GradientCellBackgroundView

@synthesize seperatorColor = _seperatorColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.seperatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 
                                               blue:208.0/255.0 alpha:1.0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame DrawSeperator:(NSNumber *)drawSeperator
{
    self = [super initWithFrame:frame];
    if(self)
    {
        if([drawSeperator boolValue])
        {
            self.seperatorColor = [UIColor whiteColor];
        }else{
            
            self.seperatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 
                                                   blue:208.0/255.0 alpha:1.0];
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 
                                             blue:1.0 alpha:1.0]; 
//    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 
//                                                 blue:230.0/255.0 alpha:1.0];
    
    CGRect paperRect = self.bounds;
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, paperRect);
    
    // Add in color section
//    UIColor *separatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 
//                                                 blue:208.0/255.0 alpha:1.0];
    
    // Add at bottom
    CGPoint startPoint = CGPointMake(paperRect.origin.x, 
                                     paperRect.origin.y + paperRect.size.height - 1);
    CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, 
                                   paperRect.origin.y + paperRect.size.height - 1);
    
    draw1PxStroke(context, startPoint, endPoint, self.seperatorColor.CGColor);
    
    //drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGrayColor.CGColor);
}

@end
