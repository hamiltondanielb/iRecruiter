//
//  SelectedNumberView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectedNumberView.h"

@interface SelectedNumberView()

- (void)setupView;

@end

@implementation SelectedNumberView

@synthesize selectedNumber = _selectedNumber;
@synthesize tapGesture = _tapGesture;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
//    _tapGesture = [[UITapGestureRecognizer alloc] init];
//    [self addGestureRecognizer:_tapGesture];
//    
//    self.backgroundColor = [UIColor clearColor];
//    
//    _selectedNumber = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
//    _selectedNumber.backgroundColor = [UIColor clearColor];
//    _selectedNumber.textAlignment = UITextAlignmentCenter;
//    _selectedNumber.font = [UIFont systemFontOfSize:18.0];
//    _selectedNumber.textColor = [UIColor whiteColor];
//    _selectedNumber.text = @"1";
//    _selectedNumber.userInteractionEnabled = NO;
//    [self addSubview:_selectedNumber];
}

- (void)viewDidLoad
{
    //_selectedNumber.center = self.center;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef redColor = [UIColor redColor].CGColor;
    CGContextSetFillColorWithColor(context, redColor);
    //CGContextFillEllipseInRect(context, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
}


@end
