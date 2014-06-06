//
//  CandidateTableViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/6/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsTableViewController.h"
#import "MajorViewController.h"
#import "LocationPickerViewController.h"
#import "TechnicalSkillsTableViewController.h"
#import "TeamTableViewController.h"
#import "ScreenDocument.h"
#import "Candidate.h"
#import "PlaceholderView.h"
#import "GradDateViewController.h"
#import "ShadowTableHeaderView.h"
#import "ShadowTableFooterView.h"
#import "MBProgressHUD.h"

@interface CandidateTableViewController : UITableViewController <UIPopoverControllerDelegate, MajorDelegate, LocationDelegate, GradDateDelegate, TechnicalSkillsDelegate,TeamDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    //LoginModalViewController* loginModa;
}

@property (strong, nonatomic) ScreenDocument *screenDoc;
@property (strong, nonatomic) ScreenDocument *tempScreeningDocument;
@property (strong, nonatomic) Candidate *candidate;

@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradDateLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sponsorshipControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelOfEducationControl;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *overallGPATextField;
@property (weak, nonatomic) IBOutlet UITextField *majorGPATextField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeBarButton;

- (IBAction)homeBarButtonPressed:(UIBarButtonItem *)sender;
- (void)newScreeningSelected;
- (IBAction)showScreeningPopover:(id)sender;
@end
