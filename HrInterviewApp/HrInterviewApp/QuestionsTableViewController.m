//
//  QuestionsTableViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsTableViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface QuestionsTableViewController()
    
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)questionsChanged:(id)sender;

@end

@implementation QuestionsTableViewController

@synthesize masterPopoverController = _masterPopoverController;

NSArray *questionArray;
ScreenDocument *_screenDocument;
UIView *placeHolder;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
            }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (ScreenDocument *)screening
{
    return _screenDocument;
}

- (void)fetchQuestionsFromScreenDocument {
    // Get the screening
//    NSError *error;
//    NSFetchRequest *screeningFetch = [[NSFetchRequest alloc] initWithEntityName:@"Screening"];
//    Screening *screening = [[self.screening.managedObjectContext executeFetchRequest:screeningFetch error:&error] lastObject];
    
    NSError *error;
    NSFetchRequest *candidateFetch = [NSFetchRequest fetchRequestWithEntityName:@"Candidate"];
    
    // Get the candidate
    Candidate *candidate = [[self.screening.managedObjectContext executeFetchRequest:candidateFetch error:&error] lastObject];        
    
    if(candidate){
        // Load all the questions for that major
        questionArray = [candidate.questions sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"text" ascending:YES]]];
    }else{
        NSLog(@"No Candidate found!!!");
    }
}

- (void)setScreening:(ScreenDocument *)screening{
    _screenDocument = screening;
//    if(_screenDocument != nil){
//        if(placeHolder != nil){
//            NSLog(@"Removing Placeholder for Questions");
//            [UIView animateWithDuration:0.5 animations:^{
//                placeHolder.alpha = 0.0;
//            } completion:^(BOOL finished) {
//                [placeHolder removeFromSuperview];
//            }];
//        }
//        
//        //[self fetchQuestionsFromScreenDocument];
//        
//        [self.tableView reloadData];
//    }
}

- (void)performPushReviewSegue
{
    [self performSegueWithIdentifier:@"PushReview" sender:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seamlesstexture30_1200.jpg"]];
    
    self.tableView.backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    self.tableView.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book-cover-011.png"]];
    
    [self fetchQuestionsFromScreenDocument];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(ratingChanged:) 
                                                 name:@"RatingDidChangeNotification" 
                                               object:nil];
    
    // Create custom 'forward' button and add it to the nav control
    UIButton *forwardButton = [UIButton buttonWithType:101];
    forwardButton.transform = CGAffineTransformMakeScale(-1,1);
    forwardButton.titleLabel.transform = CGAffineTransformMakeScale(-1,1);
    [forwardButton setTitle:@"Review" forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(performPushReviewSegue) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *reviewButton = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = reviewButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Check for a screen document, if none is loaded need to display placeholder
//    if(_screenDocument == nil){
//        placeHolder = [[PlaceholderView alloc] initWithFrame:self.view.frame MessageText:@"Please choose a screening or create a new one"];
//        placeHolder.backgroundColor = [UIColor lightGrayColor];
//        [self.view addSubview:placeHolder];
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Only support Portrait
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    else
        return NO;
}

#pragma mark View Overides

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PushReview"]){
        ReviewTableViewController *reviewTVC = (ReviewTableViewController *)[segue destinationViewController];
        reviewTVC.screenDocument = self.screening;
    }
}

#pragma mark Instance Methods

- (void)questionsChanged:(NSNotification *)notification
{
//    if([notification.userInfo objectForKey:@"readiness"] == @"YES" || notification == nil){
//        // Custom initialization
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TechnicalQuestion"];
//        NSManagedObjectContext *context = [[[ScreenDocument sharedInstance] document] managedObjectContext];
//        
//        NSError *error;
//        if([[ScreenDocument sharedInstance] isDocumentReady]){
//            questionArray = [context executeFetchRequest:request error:&error];
//            
//            if(questionArray == nil){
//                NSLog(@"Failed to get questions, error: %@",error);
//            }
//        }else{
//            NSLog(@"Document wasn't ready");
//            questionArray = [NSArray arrayWithObject:nil];
//        }
//        
//        [[self tableView] reloadData];
//    }
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
    return [questionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestionCell";
    
    QuestionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(indexPath.row == (questionArray.count - 1)){
        cell.drawSeperator = [NSNumber numberWithInt:1];
    }
    
    if (cell == nil) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    TechnicalQuestion *question = (TechnicalQuestion *)[questionArray objectAtIndex:indexPath.row];
    cell.ratingView.question = question;
    
    if(question.response){
        cell.ratingView.selectedCircle.selectedNumber.text = [NSString stringWithFormat:@"%@",question.response.value];
    }
    
    cell.questionLabel.text = question.text;
    
    return cell;
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

#pragma mark - Notifications

- (void)ratingChanged:(NSNotification *)notification
{
    NSLog(@"Fired notification method");
    RatingView *ratingView = (RatingView *)[notification object];
    TechnicalQuestion *question = ratingView.question;
    
    Response *responseEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Response" inManagedObjectContext:self.screening.managedObjectContext];
    
    question.response = responseEntry;
    responseEntry.value = [NSNumber numberWithInt:[ratingView.selectedCircle.selectedNumber.text intValue]];
    
    NSLog(@"Adding response: %d for question: %@ for candidate: %@",responseEntry.value.intValue,question.text,question.candidate.name);
    [TestFlight passCheckpoint:@"Selected a New Rating"];
}
@end
