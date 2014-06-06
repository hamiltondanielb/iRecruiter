//
//  ShadowView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShadowView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShadowView

@synthesize shadowOpacity = _shadowOpacity;
@synthesize shadowRadius = _shadowRadius;
@synthesize xOffset = _xOffset;
@synthesize yOffset = _yOffset;

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
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:[self.shadowOpacity floatValue] / 100];
    [self.layer setShadowRadius:[self.shadowRadius floatValue]];
    [self.layer setShadowOffset:CGSizeMake([self.xOffset floatValue], [self.yOffset floatValue])];
}

@end
