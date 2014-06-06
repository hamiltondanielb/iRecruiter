//
//  SelectedNumberView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedNumberView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *selectedNumber;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@end
