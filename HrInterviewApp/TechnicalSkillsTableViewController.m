//
//  TechnicalSkillsTableViewController.m
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/21/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "TechnicalSkillsTableViewController.h"

@interface TechnicalSkillsTableViewController ()

@end

@implementation TechnicalSkillsTableViewController

@synthesize selectedValue = _selectedValue;
@synthesize delegate;
@synthesize technicalSkillsArray = _technicalSkillsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _technicalSkillsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    TechnicalSkill *skill = (TechnicalSkill *)[_technicalSkillsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = skill.name;
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TechnicalSkill *skill = (TechnicalSkill *)[_technicalSkillsArray objectAtIndex:indexPath.row]; 
    if(_selectedValue == nil)_selectedValue = [[NSMutableArray alloc] init];
    [_selectedValue addObject:skill];
}

- (IBAction)doneButtonPressed:(id)sender 
{
    
    [self.delegate TechnicalSkillsWereSelected:_selectedValue];
}
@end
