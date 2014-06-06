//
//  ReviewViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/9/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenDocument.h"
#import "TechnicalQuestion.h"
#import "Response.h"
#import "RatingCircleView.h"
#import "ShadowTableHeaderView.h"
#import "ShadowTableFooterView.h"
#import "TeamTableViewController.h"

@interface ReviewTableViewController : UITableViewController <UIPopoverControllerDelegate, TeamDelegate>

@property (nonatomic,strong) ScreenDocument *screenDocument;
@property (nonatomic,weak) IBOutlet UIView *contentBackgroundView;
@property (nonatomic,weak) IBOutlet UILabel *candidateNameLabel;
@property (nonatomic,weak) IBOutlet UIButton *hotButton;
@property (nonatomic,weak) IBOutlet UILabel *candidateRatingLabel;
@property (nonatomic,weak) IBOutlet RatingCircleView *ratingCircleView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *communicationControl;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

- (IBAction)hotButtonPressed:(id)sender;
- (IBAction)communicationScoreSelected:(id)sender;

@end
