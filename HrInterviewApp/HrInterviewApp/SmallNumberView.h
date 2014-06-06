//
//  SmallNumberView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallNumberView : UIView

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@end
