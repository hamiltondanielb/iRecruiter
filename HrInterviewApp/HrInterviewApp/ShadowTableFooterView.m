//
//  ShadowTableFooterView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShadowTableFooterView.h"

@implementation ShadowTableFooterView

@synthesize titleLabel = _titleLabel;
@synthesize lightColor = _lightColor;

- (id)init {
    if ((self = [super init])) {
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
    self.opaque = NO;
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = UITextAlignmentLeft;
    _titleLabel.opaque = NO;
    _titleLabel.backgroundColor = [UIColor clearColor];
    //_titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    _titleLabel.font = [UIFont fontWithName:@"Arial" size:20.0];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabel.shadowOffset = CGSizeMake(0, -1);
    [self addSubview:_titleLabel];
    self.lightColor = [UIColor colorWithRed:58.0f/255.0f green:101.0f/255.0f 
                                       blue:138.0f/255.0f alpha:1.0];
}

-(void) layoutSubviews {
    CGFloat coloredBoxWidthMargin = 30.0;
    CGFloat coloredBoxHeight = 40.0;
    _coloredBoxRect = CGRectMake(coloredBoxWidthMargin, 
                                 0.0, 
                                 self.bounds.size.width-coloredBoxWidthMargin*2, 
                                 coloredBoxHeight);
    
    CGFloat paperMargin = 44.0;
    _paperRect = CGRectMake(paperMargin, 
                            0.0, 
                            self.bounds.size.width-paperMargin*2, 
                            3.0);
    
    //_titleLabel.frame = _coloredBoxRect;
    _titleLabel.frame = CGRectMake(_coloredBoxRect.origin.x + 10.0,_coloredBoxRect.origin.y,_coloredBoxRect.size.width,_coloredBoxRect.size.height);
}

// Replace drawRect with the following
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();    
    
//    UIColor *whiteColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 
//                                             blue:230.0/255.0 alpha:1.0];
    UIColor *whiteColor = [UIColor whiteColor];
    
    UIColor *shadowColor = [UIColor colorWithRed:0.0 green:0.0 
                                              blue:0.0 alpha:1.0];
    
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 7), 10.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, _paperRect);
    CGContextRestoreGState(context);}


@end
