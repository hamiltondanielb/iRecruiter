//
//  QuestionTableCell.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "GradientCellBackgroundView.h"

@interface QuestionTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet RatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic, strong) NSNumber *drawSeperator;

@end
