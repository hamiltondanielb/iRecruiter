//
//  TechnicalSkillsTableViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/21/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TechnicalSkill.h"

@class TechnicalSkillsTableViewController;

@protocol TechnicalSkillsDelegate <NSObject>

@required
//NSArray of TechnicalSkill
- (void)TechnicalSkillsWereSelected:(NSArray *)technicalSkills;

@end

@interface TechnicalSkillsTableViewController : UITableViewController
{
    id <TechnicalSkillsDelegate> delegate;
}
@property (strong, nonatomic) NSMutableArray *selectedValue;
@property (strong, nonatomic) id <TechnicalSkillsDelegate> delegate;
@property (strong, nonatomic) NSArray *technicalSkillsArray;


- (IBAction)doneButtonPressed:(id)sender;
@end
