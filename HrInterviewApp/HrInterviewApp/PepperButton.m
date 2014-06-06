//
//  PepperButton.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PepperButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation PepperButton
bool toggleState;


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
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0,7.5);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 0.4;
    
    toggleState = NO;
    
    [self addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)buttonTouched:(id)sender
{
    if(toggleState)
    {
        toggleState = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0,7.5);
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 0.4;
    }else{
        toggleState = YES;
        self.layer.shadowColor = [UIColor redColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0,0.0);
        self.layer.shadowRadius = 10.0;
        self.layer.shadowOpacity = 0.9;
    }
}


@end
