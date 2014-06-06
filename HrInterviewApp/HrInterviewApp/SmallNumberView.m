//
//  SmallNumberView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmallNumberView.h"

@interface SmallNumberView()

- (void)setupView;

@end

@implementation SmallNumberView

@synthesize numberLabel = _numberLabel;
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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
// 
//    CGColorRef blueColor = [UIColor blueColor].CGColor;
//    CGContextSetFillColorWithColor(context, blueColor);
//    
//    float width = self.frame.size.width / 2;
//    float height = self.frame.size.height / 2;
//    
//    float x = width - (width / 2);
//    
//    float y = height - (height / 2);
//    
//    
//    CGContextFillEllipseInRect(context, CGRectMake(x,y,width,height));
//}

- (void)setupView
{
    //_tapGesture = [[UITapGestureRecognizer alloc] init];
    //[self addGestureRecognizer:_tapGesture];
    
    //self.backgroundColor = [UIColor clearColor];
    
    //_numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    //_numberLabel.backgroundColor = [UIColor clearColor];
    //_numberLabel.textColor = [UIColor clearColor];
    //_numberLabel.font = [UIFont systemFontOfSize:18.0];
    //_numberLabel.textAlignment = UITextAlignmentCenter;
    //[self addSubview:_numberLabel];
}

- (void)viewDidLoad
{
    //_numberLabel.center = self.center;
}

@end
