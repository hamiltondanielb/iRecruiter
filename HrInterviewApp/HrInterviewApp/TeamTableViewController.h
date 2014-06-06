//
//  TeamTableViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/21/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeamTableViewController;

@protocol TeamDelegate <NSObject>

@required
//NSArray of TechnicalSkill
- (void)teamsWereSelected:(NSArray *)teams;

@end

@interface TeamTableViewController : UITableViewController
{
    id <TeamDelegate> delegate;
}
@property (strong, nonatomic) NSArray *selectedValue;
@property (strong, nonatomic) id <TeamDelegate> delegate;
@property (strong, nonatomic) NSArray *teamsArray;

- (IBAction)doneButtonPressed:(id)sender;
@end
