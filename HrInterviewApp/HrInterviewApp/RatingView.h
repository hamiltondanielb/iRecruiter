//
//  RatingView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectedNumberView.h"
#import "SmallNumberView.h"
#import "Screening.h"
#import "Response.h"

@class RatingView;

@interface RatingView : UIView
{
}

@property (strong, nonatomic) IBOutlet SelectedNumberView *selectedCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberOneCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberTwoCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberThreeCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberFourCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberFiveCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberSixCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberSevenCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberEightCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberNineCircle;
@property (strong, nonatomic) IBOutlet SmallNumberView *numberTenCircle;
@property (strong, nonatomic) TechnicalQuestion *question;


- (IBAction)revealNumbers:(UIGestureRecognizer *)gestureRecognizer;
- (IBAction)selectNumber:(UIGestureRecognizer *)gestureRecognizer;

@end
