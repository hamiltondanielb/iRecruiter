//
//  RecruitingTestViewController.h
//  RecruitingTest
//
//  Created by Scott on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewTableViewController.h"

@interface NotesViewController : UIViewController
<UITextViewDelegate>
{
    IBOutlet UIView *notesTextView;
}

@property (nonatomic, retain) IBOutlet UITextView *notesTextView;
@property (strong, nonatomic) ScreenDocument *screening;

@end
