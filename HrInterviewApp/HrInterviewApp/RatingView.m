//
//  RatingView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RatingView.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees) ((degrees) * (M_PI / 180.0))

@interface RatingView()
{
    BOOL revealed;
}

@property (nonatomic, strong) NSArray *numberArray;

- (void)setupView;
- (int)determineAngleInDegreesForPoint:(CGPoint)firstPoint SecondPoint:(CGPoint)secondPoint;
- (int)determineRadiusForPoint:(CGPoint)firstPoint SecondPoint:(CGPoint)secondPoint;
//- (UIBezierPath *)createBezierFromCenterWithRadius:(int)arcRadius Degree:(int)degree;
- (CGPoint)determinePointOnCircleWithRadius:(int)radius Degree:(int)degree;

@end

@implementation RatingView


@synthesize selectedCircle = _selectedCircle;
@synthesize numberOneCircle = _numberOneCircle;
@synthesize numberTwoCircle = _numberTwoCircle;
@synthesize numberThreeCircle = _numberThreeCircle;
@synthesize numberFourCircle = _numberFourCircle;
@synthesize numberFiveCircle = _numberFiveCircle;
@synthesize numberSixCircle = _numberSixCircle;
@synthesize numberSevenCircle = _numberSevenCircle;
@synthesize numberEightCircle = _numberEightCircle;
@synthesize numberNineCircle = _numberNineCircle;
@synthesize numberTenCircle = _numberTenCircle;
@synthesize question = _question;

@synthesize numberArray = _numberArray;

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
    revealed = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberOneCircle.tapGesture = tapOne;
    [_numberOneCircle addGestureRecognizer:tapOne];
    
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberTwoCircle.tapGesture = tapTwo;
    [_numberTwoCircle addGestureRecognizer:tapTwo];
    
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberThreeCircle.tapGesture = tapThree;
    [_numberThreeCircle addGestureRecognizer:tapThree];
    
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberFourCircle.tapGesture = tapFour;
    [_numberFourCircle addGestureRecognizer:tapFour];
    
    UITapGestureRecognizer *tapFive = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberFiveCircle.tapGesture = tapFive;
    [_numberFiveCircle addGestureRecognizer:tapFive];
    
    UITapGestureRecognizer *tapSix = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberSixCircle.tapGesture = tapSix;
    [_numberSixCircle addGestureRecognizer:tapSix];
    
    UITapGestureRecognizer *tapSeven = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberSevenCircle.tapGesture = tapSeven;
    [_numberSevenCircle addGestureRecognizer:tapSeven];
    
    UITapGestureRecognizer *tapEight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberEightCircle.tapGesture = tapEight;
    [_numberEightCircle addGestureRecognizer:tapEight];
    
    UITapGestureRecognizer *tapNine = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberNineCircle.tapGesture = tapNine;
    [_numberNineCircle addGestureRecognizer:tapNine];
    
    UITapGestureRecognizer *tapTen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumber:)];
    _numberTenCircle.tapGesture = tapTen;
    [_numberTenCircle addGestureRecognizer:tapTen];
    
    _numberArray = [NSArray arrayWithObjects:_numberOneCircle,_numberTwoCircle,_numberThreeCircle, _numberFourCircle, _numberFiveCircle, _numberSixCircle, _numberSevenCircle, _numberEightCircle, _numberNineCircle, _numberTenCircle, nil];
    
    for(SmallNumberView *view in _numberArray){
        view.center = _selectedCircle.center;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(revealNumbers:)];
    _selectedCircle.tapGesture = tapGesture;
    [_selectedCircle addGestureRecognizer:tapGesture];
}

- (CGPoint)determinePointOnCircleWithRadius:(int)radius Degree:(int)degree
{
    float midX = _selectedCircle.center.x + radius * cos(DEGREES_TO_RADIANS(degree));
    float midY = _selectedCircle.center.y + radius * sin(DEGREES_TO_RADIANS(degree));
    
    return CGPointMake(midX, midY);
}

- (int)determineAngleInDegreesForPoint:(CGPoint)firstPoint SecondPoint:(CGPoint)secondPoint
{
    int deltaX = firstPoint.x - secondPoint.x;
    int deltaY = firstPoint.y - secondPoint.y;
    
    return atan2(deltaY, deltaX) * 180 / M_PI;
}

- (int)determineRadiusForPoint:(CGPoint)firstPoint SecondPoint:(CGPoint)secondPoint
{
    int deltaX = firstPoint.x - secondPoint.x;
    int deltaY = firstPoint.y - secondPoint.y;
    
    return sqrt(pow(deltaX,2)+pow(deltaY,2));
}



- (IBAction)revealNumbers:(UIGestureRecognizer *)gestureRecognizer
{    
    NSLog(@"Reveal Numbers called");
    
    if(revealed){
        NSLog(@"Numbers are revealed, hiding");
        for(SmallNumberView *view in _numberArray){
            
            [UIView animateWithDuration:0.2 
                                  delay:0.0 
                                options:UIViewAnimationOptionCurveEaseIn 
                             animations:^{
                                 view.center = _selectedCircle.center;
                             } 
                             completion:^(BOOL finished) {
                                 revealed = NO;
                             }];
            
        }
         
    }else{
        NSLog(@"Numbers are not revealed, opening");
        for(SmallNumberView *view in _numberArray){
            
            NSNumber *index = [NSNumber numberWithInt:[_numberArray indexOfObject:view]];
            
            float x = (0 + (50.0 * [index intValue]) + 25.0);
            float y = 25.0;
                        
            [UIView animateWithDuration:0.2 
                                  delay:0.0 
                                options:UIViewAnimationOptionCurveEaseIn 
                             animations:^{
                                 view.center = CGPointMake(x, y);
                                        } 
                             completion:^(BOOL finished) {
                                 revealed = YES;
                             }];
            
        }
        
    }
}

- (void)selectNumber:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"Small Number selected");
    
    if(revealed){
        SmallNumberView *targetView = (SmallNumberView *)gestureRecognizer.view;
        
        NSString *selectedNumberString = targetView.numberLabel.text;        
        NSLog(@"Selected %@",selectedNumberString);
        
        // Change the number for selected number view
        _selectedCircle.selectedNumber.text = selectedNumberString;
        _selectedCircle.backgroundColor = targetView.backgroundColor;
        [self revealNumbers:nil];
        
        // Send the delegate a message indicating there was a response;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RatingDidChangeNotification" object:self];
    }
}

@end
