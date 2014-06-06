//
//  LoginModalBackgroundView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginModalBackgroundView.h"

@implementation LoginModalBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.layer.masksToBounds = YES;
    
    [self.layer setCornerRadius:10.0f];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:3.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef redColor = 
    [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    
    CGContextSetFillColorWithColor(context, redColor);
    CGContextFillRect(context, self.frame);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0].CGColor);
    
    CGFloat xPos = -50.0;
    NSLog(@"Setting xPos to %f",xPos);
    
    CGFloat yPos = 50.0;
    NSLog(@"Setting yPos to %f",yPos);
    
    CGFloat width = 600.0;
    CGFloat height = 300.0;
    
    CGRect ellipseFrame = CGRectMake(xPos, yPos, width, height);
    
    CGContextFillEllipseInRect(context, ellipseFrame);
}


@end
