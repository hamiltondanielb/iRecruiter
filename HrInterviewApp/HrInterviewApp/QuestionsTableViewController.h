//
//  QuestionsTableViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionTableCell.h"
#import "ScreenDocument.h"
#import "PlaceholderView.h"
#import "Candidate.h"
#import "Candidate+Factory.h"
#import "Major.h"
#import "TechnicalQuestion.h"
#import "Response.h"
#import "NotesViewController.h"
#import "RatingView.h"
#import "ReviewTableViewController.h"
#import "ShadowTableFooterView.h"

@interface QuestionsTableViewController : UITableViewController

@property (strong, nonatomic) ScreenDocument *screening;

@end
