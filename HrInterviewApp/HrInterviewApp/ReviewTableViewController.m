//
//  ReviewViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/9/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "ReviewTableViewController.h"

@interface ReviewTableViewController ()

@end

@implementation ReviewTableViewController{
    __weak UIPopoverController *teamPopover;
}
@synthesize communicationControl = _communicationControl;
@synthesize notesTextView = _notesTextView;
@synthesize screenDocument = _screenDocument;
@synthesize contentBackgroundView = _contentBackgroundView;
@synthesize candidateNameLabel = _candidateNameLabel;
@synthesize hotButton = _hotButton;
@synthesize candidateRatingLabel = _candidateRatingLabel;
@synthesize ratingCircleView = _ratingCircleView;

Candidate *_candidate;

-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set Background texture
    self.tableView.backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    self.tableView.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book-cover-011.png"]];
    
    // Set content background
    self.contentBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"seamlesstexture11_1200.png"]];
    
    // Add GestureRecognizer to allow for tapping the background to dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    // Load candidate
    NSError *error;
    NSFetchRequest *candidateRequest = [NSFetchRequest fetchRequestWithEntityName:@"Candidate"];
    NSArray *candidateArray = [self.screenDocument.managedObjectContext executeFetchRequest:candidateRequest error:&error];
    
    if(error)
        NSLog(@"Error fetching candidate: %@",error);
    
    NSLog(@"Found %d candidate",candidateArray.count);
    
    if(candidateArray.count < 1){
        NSLog(@"No candidate, wha wha");
    }else{
        _candidate = (Candidate *)[candidateArray lastObject];
        if(_candidate){
            self.candidateNameLabel.text = _candidate.name;
            
            NSArray *questions = [_candidate.questions allObjects];
            int ratingCount = 0;
            double ratingTotal = 0.0;
            
            for (TechnicalQuestion *question in questions) {
                if(question.response.value){
                    ratingCount++;
                    ratingTotal = ratingTotal + [question.response.value doubleValue];
                }
            }
            NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
            [fmt setPositiveFormat:@"0.##"];
            NSString *ratingValueString = [fmt stringFromNumber:[NSNumber numberWithInteger:round((ratingTotal / ratingCount))]];
            self.candidateRatingLabel.text = ratingValueString;
            
            // Get colors from PList
            NSString *path = [[NSBundle mainBundle] pathForResource:@"RatingColors" ofType:@"plist"];
            NSDictionary *colorDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
            
            // Assign color of background view to rating color
            NSDictionary *colorInformation = [colorDictionary objectForKey:ratingValueString];
            
            CGFloat red = [(NSNumber *)[colorInformation objectForKey:@"red"] floatValue];
            CGFloat green = [(NSNumber *)[colorInformation objectForKey:@"green"] floatValue];
            CGFloat blue = [(NSNumber *)[colorInformation objectForKey:@"blue"] floatValue];
            
            UIColor *ratingCircleColor = [UIColor colorWithRed:red / 255.0f
                                                        green:green / 255.0f
                                                         blue:blue / 255.0f
                                                        alpha:1.0];
            
            //UIColor *ratingCircleColor = [UIColor colorWithRed:69.0f/255.0f green:122.0f/255.0f blue:166.0f/255.0f alpha:1.0];
            
            self.ratingCircleView.circleColor = [UIColor whiteColor];
            
            self.candidateRatingLabel.textColor = ratingCircleColor;
            
            NSLog(@"Rating Circle Views Color is %@",self.ratingCircleView.circleColor);
            
            const CGFloat* components = CGColorGetComponents(ratingCircleColor.CGColor);
            NSLog(@"Red: %f", components[0]);
            NSLog(@"Green: %f", components[1]); 
            NSLog(@"Blue: %f", components[2]);
            if(_candidate.hot){
                self.hotButton.selected = [_candidate.hot boolValue];
            }
            if(_candidate.communicationSkill){
                self.communicationControl.selectedSegmentIndex = _candidate.communicationSkill.intValue - 1;
            }
            if(_candidate.notes)
            {
                self.notesTextView.text = _candidate.notes;
            }
        }
    }

}

- (void)viewDidUnload
{
    [self setCommunicationControl:nil];
    [self setNotesTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hotButtonPressed:(id)sender {
    if([_candidate.hot isEqualToNumber:[NSNumber numberWithBool:YES]]){
        _candidate.hot = [NSNumber numberWithBool:NO];
        self.hotButton.selected = NO;
    }else{
        _candidate.hot = [NSNumber numberWithBool:YES];
        self.hotButton.selected = YES;
    }
}

- (IBAction)communicationScoreSelected:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *) sender;
    switch (control.selectedSegmentIndex)
    {
        case 0:
            _candidate.communicationSkill = [NSNumber numberWithInt:1];
            break;
        case 1:
            _candidate.communicationSkill = [NSNumber numberWithInt:2];
            break;
        case 2:
            _candidate.communicationSkill = [NSNumber numberWithInt:3];
            break;
        case 3:
            _candidate.communicationSkill = [NSNumber numberWithInt:4];
            break;
        case 4:
            _candidate.communicationSkill = [NSNumber numberWithInt:5];
            break;
            
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.screenDocument saveToURL:self.screenDocument.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if(!success){
            NSLog(@"Document failed to save!");
        }
    }];
    
    if([[segue identifier] isEqualToString:@"ModalScreenDocument"]){
        [TestFlight passCheckpoint:@"Returning to Dashboard from Review page"];
    }
    
    if([[segue identifier] isEqualToString:@"TeamPopover"]){
        
        [self prepareTeamPopover:segue];
    }
}

#pragma mark - Instance Variables

- (void)prepareTeamPopover:(UIStoryboardSegue *)segue {
    UINavigationController *teamNav = (UINavigationController *)[segue destinationViewController];
    TeamTableViewController *teamViewController = [teamNav.viewControllers objectAtIndex:0];
    teamViewController.delegate = self;
#warning TODO: pass team information to popover
    
    teamPopover = [(UIStoryboardPopoverSegue *) segue popoverController];
}

#pragma mark Team Protocal
-(void)teamsWereSelected:(NSArray *)teams
{
    if(teamPopover)
        [teamPopover dismissPopoverAnimated:YES];
}

#pragma mark - Table View Data Source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShadowTableHeaderView *header = [[ShadowTableHeaderView alloc] init];    
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ShadowTableFooterView *footer = [[ShadowTableFooterView alloc] init];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

#pragma mark - UITextField
- (void) textViewDidEndEditing:(UITextView *)textView{
    if ([textView isEqual:self.notesTextView]) {
        _candidate.notes = self.notesTextView.text;
    }
}
@end
