//
//  CandidateTableViewController.m
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/6/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "CandidateTableViewController.h"

@interface CandidateTableViewController()
@end

@implementation CandidateTableViewController{
    __weak UIPopoverController *screeningPopover;
    __weak UIPopoverController *majorPopover;
    __weak UIPopoverController *locationPopover;
    __weak UIPopoverController *gradDatePopover;
    __weak UIPopoverController *techSkillsPopover;
    __weak UIPopoverController *teamPopover;
}

#pragma mark - Properties
@synthesize nameTextField;
@synthesize overallGPATextField;
@synthesize majorGPATextField;
@synthesize emailAddressField;
@synthesize notesTextView;
@synthesize homeBarButton;

@synthesize tempScreeningDocument = _tempScreeningDocument;
@synthesize majorLabel = _majorLabel;
@synthesize locationLabel;
@synthesize gradDateLabel;
@synthesize sponsorshipControl;
@synthesize levelOfEducationControl;
@synthesize candidate = _candidate;
@synthesize screenDoc = _screening;

#pragma mark - Instance Variables
PlaceholderView *_placeholder;
NSString *_currentScreeningFilename;
MBProgressHUD *progress;

- (IBAction)homeBarButtonPressed:(UIBarButtonItem *)sender {
    [TestFlight passCheckpoint:@"Returning Home from Candidate"];
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.labelText = @"Saving Screening";
    progress.removeFromSuperViewOnHide = YES;
    
    [self.screenDoc saveToURL:self.screenDoc.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        progress.hidden = YES;
        if(success)
        {
            NSLog(@"Document was successfully saved before returning home");
            [self performSegueWithIdentifier:@"ReturnHome" sender:self];
        }else{
            NSLog(@"Document failed to save on returning home");
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Proglem" message:@"There was a problem saving your screening.  If this continues to happen, please contact support." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [errorAlert show];
        }
    }];
    
}

- (void)newScreeningSelected
{
    NSLog(@"New Screening selected");
}

- (IBAction)showScreeningPopover:(id)sender{
    if (screeningPopover) 
        [screeningPopover dismissPopoverAnimated:YES];
    else
        [self performSegueWithIdentifier:@"ScreeningTableViewControllerPopover" sender:sender];
}

- (void)prepareMajorPopover:(UIStoryboardSegue *)segue {
    //Fetch all majors in document;
    NSFetchRequest *majorRequest = [NSFetchRequest fetchRequestWithEntityName:@"Major"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    majorRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *majorArray = [self.screenDoc.managedObjectContext executeFetchRequest:majorRequest error:&error];
    
    //get destination of major view controller
    UINavigationController *majorNav = (UINavigationController *)[segue destinationViewController];
    MajorViewController *majorViewController = [majorNav.viewControllers objectAtIndex:0];
    //register for delegate
    majorViewController.delegate = self;
    
    //set done button to disabled if no values in array;
    if(majorArray.count < 1){
        majorViewController.navigationItem.rightBarButtonItem.enabled = NO;
    }else {
        majorViewController.navigationItem.rightBarButtonItem.enabled = YES;
        
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"self.name == %@",self.majorLabel.text];
        NSArray *filteredScreenings = [majorArray filteredArrayUsingPredicate:filter];
        
        majorViewController.selectedValue = [filteredScreenings lastObject];
    }
    //set major array in popover class
    majorViewController.majorArray = majorArray;
    
    //weak reference to segue to prevent from repopping
    majorPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
}

- (void)prepareLocationPopover:(UIStoryboardSegue *)segue {
    //Fetch all locations in document
    NSFetchRequest *locationRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    locationRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *locationArray = [self.screenDoc.managedObjectContext executeFetchRequest:locationRequest error:&error];
    NSLog(@"Size of locationArray = %d", locationArray.count);
    
    UINavigationController *locationNav = (UINavigationController *)[segue destinationViewController];
    LocationPickerViewController *locationViewController = [locationNav.viewControllers objectAtIndex:0];
    locationViewController.delegate = self;
    
    //set done button to disabled if no values in array;
    if(locationArray.count < 1){
        locationViewController.navigationItem.rightBarButtonItem.enabled = NO;
    }else {
        locationViewController.navigationItem.rightBarButtonItem.enabled = YES;
        
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"self.name == %@",self.locationLabel.text];
        NSArray *filteredScreenings = [locationArray filteredArrayUsingPredicate:filter];
        
        locationViewController.selectedValue = [filteredScreenings lastObject];
    }
    
    locationViewController.locationArray = locationArray;
    
    locationPopover = [(UIStoryboardPopoverSegue *) segue popoverController];
}

- (void)prepareGradDatePopover:(UIStoryboardSegue *)segue {
    UINavigationController *gradDateNav = (UINavigationController *)[segue destinationViewController];
    GradDateViewController *gradDateViewController = [gradDateNav.viewControllers objectAtIndex:0];
    gradDateViewController.delegate = self;
    
    if (self.candidate.graduationDate != nil) {
        NSLog(@"the current grad date is %@",self.candidate.graduationDate);
        [gradDateViewController.gradDatePicker setDate:self.candidate.graduationDate];
    }
    
    gradDatePopover = [(UIStoryboardPopoverSegue *) segue popoverController];
}

- (void)prepareTechnicalSkillsPopover:(UIStoryboardSegue *)segue {
    //Fetch all locations in document
    NSFetchRequest *techSkillsRequest = [NSFetchRequest fetchRequestWithEntityName:@"TechnicalSkill"];
    NSError *error;
    NSArray *techSkillsArray = [self.screenDoc.managedObjectContext executeFetchRequest:techSkillsRequest error:&error];
    NSLog(@"Size of techskillsArray = %d", techSkillsArray.count);
    
    UINavigationController *techSkillsNav = (UINavigationController *)[segue destinationViewController];
    TechnicalSkillsTableViewController *techSkillsViewController = [techSkillsNav.viewControllers objectAtIndex:0];
    techSkillsViewController.delegate = self;
    techSkillsViewController.technicalSkillsArray = techSkillsArray;
    
    techSkillsPopover = [(UIStoryboardPopoverSegue *) segue popoverController];
}


- (void)prepareReturnHome {
    
}

- (void)preparePushQuestion:(UIStoryboardSegue *)segue {
    QuestionsTableViewController *questionVc = (QuestionsTableViewController *)[segue destinationViewController];
    questionVc.screening = self.screenDoc;
}

// FIXME: Refractor this method
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [self resignAllFirstResponders];
        
    if([[segue identifier] isEqualToString:@"PushQuestion"]){
        [self preparePushQuestion:segue];
    }
    
    if([[segue identifier] isEqualToString:@"MajorPopover"]){
        [self prepareMajorPopover:segue];
    }
    
    if([[segue identifier] isEqualToString:@"LocationPopover"]){
        [self prepareLocationPopover:segue];
    }
    
    if([[segue identifier] isEqualToString:@"GradDatePopover"]){
        
        [self prepareGradDatePopover:segue];
    }
    
    if([[segue identifier] isEqualToString:@"TechnicalSkillsPopover"]){
       
        [self prepareTechnicalSkillsPopover:segue];
    }
    
    if([[segue identifier] isEqualToString:@"ReturnHome"]){
        [self prepareReturnHome];
    }
    
    //do pre stuff for
}

#pragma mark - Instance Methods

- (void)showPlaceholderAnimated:(BOOL)animated
{
    if(!_placeholder)
        _placeholder = [[PlaceholderView alloc] initWithFrame:[[UIScreen mainScreen] bounds] MessageText:@"Please select or create a new screening."];
    if(animated){
        _placeholder.alpha = 0.0;
        [self.view addSubview:_placeholder];
        [UIView animateWithDuration:0.3 animations:^{
            _placeholder.alpha = 1.0; 
        }];
    }else{
        [self.view addSubview:_placeholder];
    }
}

- (void)checkValidationStatus
{
    if(self.candidate.major && self.candidate.name && self.candidate.emailAddress.length > 0){
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)loadCurrentValues
{
    [TestFlight passCheckpoint:@"Loading current values for screen document"];
    // have property on candidate view controller
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Candidate"];
    
    NSArray *candidateArray = [self.screenDoc.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    self.candidate = candidateArray.lastObject;
    
    // Set up fields with values from candidate
    self.nameTextField.text = self.candidate.name;
    
    NSLog(@"Candidate name is set to : %@", self.candidate.name);
    
    NSNumberFormatter *number = [[NSNumberFormatter alloc] init];
    number.numberStyle = NSNumberFormatterDecimalStyle;
    
    if([self.candidate.overallGpa doubleValue] > 0.0){
        self.overallGPATextField.text = [number stringFromNumber:self.candidate.overallGpa];
        self.overallGPATextField.textColor = [UIColor blackColor];
    }
    
    if([self.candidate.majorGpa doubleValue] > 0.0){
        self.majorGPATextField.text = [number stringFromNumber:self.candidate.majorGpa];
        self.majorGPATextField.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.major.name){
        self.majorLabel.text = self.candidate.major.name;
        self.majorLabel.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.notes){
        self.notesTextView.text = self.candidate.notes;
        self.notesTextView.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.location.name){
        self.locationLabel.text = self.candidate.location.name;
        self.locationLabel.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.graduationDate){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/yyyy"];
        
        NSString *stringFromDate = [formatter stringFromDate:self.candidate.graduationDate];
        self.gradDateLabel.text = stringFromDate;
        self.gradDateLabel.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.emailAddress){
        self.emailAddressField.text = self.candidate.emailAddress;
        self.emailAddressField.textColor = [UIColor blackColor];
    }
    
    if(self.candidate.major.levelOfEducation){
        if([self.candidate.major.levelOfEducation isEqualToString:@"Doctorate"]){
            self.levelOfEducationControl.selectedSegmentIndex = 2;
        }else if([self.candidate.major.levelOfEducation isEqualToString:@"Master"]){
            self.levelOfEducationControl.selectedSegmentIndex = 1;
        }else{
        self.levelOfEducationControl.selectedSegmentIndex = 0;
        }
                                                             
    }
    
    self.sponsorshipControl.selectedSegmentIndex = [self.candidate.sponsorshipNeeded intValue];
    
    [self checkValidationStatus];
}

- (void)performPushQuestionSegue
{
    [self performSegueWithIdentifier:@"PushQuestion" sender:self];
}

-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Adjust UITextField alignment for 6.0
    //self.nameTextField.textAlignment = UITextAlignmentLeft;
    //self.nameTextField.textAlignment = UITextAlignmentRight;
    
    //self.emailAddressField.textAlignment = UITextAlignmentLeft;
    //self.emailAddressField.textAlignment = UITextAlignmentRight;
    
    //self.overallGPATextField.textAlignment = UITextAlignmentLeft;
    //self.overallGPATextField.textAlignment = UITextAlignmentRight;
    
    //self.majorGPATextField.textAlignment = UITextAlignmentLeft;
    //self.majorGPATextField.textAlignment = UITextAlignmentRight;
    
    self.tableView.backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    //self.tableView.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book-cover-011.png"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(documentStateChanged:) 
                                                 name:UIDocumentStateChangedNotification 
                                               object:self.screenDoc];
    
    // Create custom 'forward' button and add it to the nav control
    UIButton *forwardButton = [UIButton buttonWithType:101];
    forwardButton.transform = CGAffineTransformMakeScale(-1,1);
    forwardButton.titleLabel.transform = CGAffineTransformMakeScale(-1,1);
    [forwardButton setTitle:@"Questions" forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(performPushQuestionSegue) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *questionsButton = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = questionsButton;
    
    questionsButton.enabled = NO;
    
    // Add GestureRecognizer to allow for tapping the background to dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [self loadCurrentValues];
    
//    if(!self.screening){
//        [self showPlaceholderAnimated:NO];
//    }
    
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setOverallGPATextField:nil];
    [self setMajorGPATextField:nil];
    [self setLocationLabel:nil];
    [self setGradDateLabel:nil];
    [self setSponsorshipControl:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setEmailAddressField:nil];
    [self setNotesTextView:nil];
    [self setHomeBarButton:nil];
    [self setNotesTextView:nil];
    [self setLevelOfEducationControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Table View Delegate

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

#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark LoginModalProtocal

- (void)loginDidFinishWithUsername:(NSString *)username EventName:(NSString *)eventName
{
    // Set session
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.session = username;
    
    // Dismiss Modal
    [self dismissModalViewControllerAnimated:YES];
    
    NSLog(@"Login Finished.  Username: %@ Event Name: %@",username,eventName);
}

#pragma mark Major Protocal

- (void)majorWasSelected:(Major *)major
{
    self.majorLabel.text = major.name;
    self.majorLabel.textColor = [UIColor blackColor];
    if(majorPopover)
        [majorPopover dismissPopoverAnimated:YES];
    self.candidate.major = major;
    [self.candidate removeQuestions:self.candidate.questions];
    [self.candidate populateTechnicalQuestions];
    [self checkValidationStatus];
}

#pragma mark Location Protocal
-(void)locationWasSelected:(Location *)location
{
    self.locationLabel.text = location.name;
    self.locationLabel.textColor = [UIColor blackColor];
    if(locationPopover)
        [locationPopover dismissPopoverAnimated:YES];
    self.candidate.location = location;
}

#pragma mark GradDate Protocal
-(void)gradDateSelected:(NSDate *)gradDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:gradDate];
    self.gradDateLabel.text = stringFromDate;
    self.gradDateLabel.textColor =[UIColor blackColor];
    
    if(gradDatePopover)
        [gradDatePopover dismissPopoverAnimated:YES];
    self.candidate.graduationDate = gradDate;
    
}

#pragma mark TechSkills Protocal
-(void)TechnicalSkillsWereSelected:(NSArray *)technicalSkills
{
    if(techSkillsPopover)
        [techSkillsPopover dismissPopoverAnimated:YES];
#warning TODO: set value to candidate
    for (id key in technicalSkills) {
        NSLog(@"key: %@, value: %@ \n", key, [technicalSkills objectAtIndex:key]);
    }
}

#pragma mark Team Protocal
-(void)teamsWereSelected:(NSArray *)teams
{
    if(teamPopover)
        [teamPopover dismissPopoverAnimated:YES];
}

#pragma mark Candidate Name and GPAs
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //check twhich text field sent message
    if ([textField isEqual:self.nameTextField]) {
        //set candidatename
        self.candidate.name = self.nameTextField.text;
        [self checkValidationStatus];
    }
    else if([textField isEqual:self.emailAddressField]){
     //set email
        self.candidate.emailAddress = self.emailAddressField.text;
        [self checkValidationStatus];
    }else if ([textField isEqual:self.majorGPATextField]) {
        //CONVERT NSString to NSNumber
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * number = [f numberFromString:self.majorGPATextField.text];
        //setmajorgpa on candidate
        self.candidate.majorGpa = number;
    }else if ([textField isEqual:self.overallGPATextField]) {
        //CONVERT NSString to NSNumber
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * number = [f numberFromString:self.overallGPATextField.text];
        //set overall gpa on candidate
        self.candidate.overallGpa = number;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    if ([textView isEqual:self.notesTextView]) {
        self.candidate.notes = self.notesTextView.text;
    }
}

#pragma mark SponorshipNeeded
- (IBAction)sponsorshipValueChanged:(UISegmentedControl *)sponsorControl 
{
    if ([[sponsorControl titleForSegmentAtIndex:sponsorControl.selectedSegmentIndex] isEqualToString:@"Yes"]) {
        self.candidate.sponsorshipNeeded = [NSNumber numberWithBool:YES];
    }
    else {
        self.candidate.sponsorshipNeeded = [NSNumber numberWithBool:NO];
;
    }
}

#pragma mark LevelOfEducation
- (IBAction)levelOfEducationValueChanged:(UISegmentedControl *)educationControl 
{
    self.candidate.major.levelOfEducation = [educationControl titleForSegmentAtIndex:educationControl.selectedSegmentIndex];  
}

-(void)resignAllFirstResponders{
    [self.nameTextField resignFirstResponder];
    [self.overallGPATextField resignFirstResponder];
    [self.majorLabel resignFirstResponder];
    [self.emailAddressField resignFirstResponder];
}

#pragma mark - Notifications

- (void)documentStateChanged:(NSNotification *)notification
{
    ScreenDocument *screenDocument = (ScreenDocument *)[notification object];
    if(screenDocument.documentState == UIDocumentStateClosed){
        NSLog(@"Document is closed, should open it");
    }else if(screenDocument.documentState == UIDocumentStateSavingError){
        NSLog(@"There was a problem saving the document");
    }else if(screenDocument.documentState == UIDocumentStateInConflict){
        NSLog(@"Document is reporting a conflict");
    }else if(screenDocument.documentState == UIDocumentStateNormal){
        NSLog(@"Document is ready!");
        //[self screenDocumentIsReady];
    }
}

@end
