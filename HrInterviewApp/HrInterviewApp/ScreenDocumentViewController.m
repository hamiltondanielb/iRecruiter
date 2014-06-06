//
//  ScreenDocumentViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/2/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "ScreenDocumentViewController.h"

@interface ScreenDocumentViewController ()

@end

@implementation ScreenDocumentViewController

@synthesize pagingScrollView = _pagingScrollView;
@synthesize pageControl = _pageControl;
@synthesize pagingWrapperView = _pagingWrapperView;
@synthesize sessionView = _sessionView;
@synthesize removeButton = _removeButton;
@synthesize logoutButton = _logoutButton;
@synthesize userNameLabel = _userNameLabel;
 
NSMutableArray *smallDocuments;
MBProgressHUD *progress;
ScreenDocument *selectedScreenDocument;
SmallDocumentViewController *selectedSmallDoc;
//NSMutableArray *screenings;

#define PAGEWIDTH 300.0
#define PADDING 20.0

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create Array to hold loaded Screen Documents from the file system
    smallDocuments = [[NSMutableArray alloc] init];
    
    // Set background tile
    UIImage *patternImage = [UIImage imageNamed:@"book-cover-011.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    // Add a gesture regonizer to expand the panning gesture of the scroll view
    [self.pagingWrapperView addGestureRecognizer:self.pagingScrollView.panGestureRecognizer];
    
    // Assign the scroll view delegate to self
    _pagingScrollView.delegate = self;
    
    // Assign width and height for drawing later
    CGFloat width = self.pagingScrollView.frame.size.width;
    CGFloat height = 400.0;
    
    // Get the Documents path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    // Get all the files in the Documents directory
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:&error];
    
    if(error != nil){
        NSLog(@"ERROR*** : %@",error);
    }
    
    // Filter the contents of the Document directory for screening documents and filter out the Template document
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.screening' AND self != %@",TemplateFilename];
    NSArray *filteredScreenings = [directoryContents filteredArrayUsingPredicate:filter];
    
    NSMutableArray *screenings = [[NSMutableArray alloc] init];
    [screenings addObjectsFromArray:filteredScreenings];
    
    // Loop through filtered out screenings and create small documents 
    for (int i = 0; i < screenings.count; i++) {
        
        // Create the frame for the small document
        CGRect frame;
        frame.origin.x = width * i;
        frame.origin.y = 0;
        frame.size = CGSizeMake(width, height);
        
        // Initialize our small document from the template in the story board
        SmallDocumentViewController *smallDocVC = (SmallDocumentViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SmallDocument"];
        
        NSLog(@"Setting label for document to %@",[screenings objectAtIndex:i]);
        
        // Set frame for small document
        smallDocVC.view.frame = frame;
        
        // Add small document to scroll view
        [self.pagingScrollView addSubview:smallDocVC.view];
        
        // Assign some properties to the small document
        smallDocVC.documentLabel.text = [[[screenings objectAtIndex:i] lastPathComponent] stringByDeletingPathExtension];
        smallDocVC.documentFileUrl = [screenings objectAtIndex:i];
        
        // Set the controller as the delegate for the small document to monitor touches coming across
        smallDocVC.delegate = self;
        
        // Keep a reference of the small document in the array
        [smallDocuments addObject:smallDocVC];
        
        [self calculateContentSizeForScrollView];
        [self setPagecount];
    }
    
    // Hide session view until view is loaded
    self.sessionView.hidden = YES;
    
    [self setRemoveButtonStatue];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setSessionView]; 
}

- (void)viewDidUnload
{
    [self setLogoutButton:nil];
    [self setUserNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Instance Methods

- (void)setSessionView
{
    // Check session
    NSDictionary *sessionData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] session];
    if(sessionData)
    {
        self.sessionView.center = CGPointMake(self.sessionView.center.x,
                                              self.sessionView.center.y - self.sessionView.frame.size.height);
        self.sessionView.hidden = NO;
        
        self.userNameLabel.text = [NSString stringWithFormat:@"Welcome, %@",[sessionData objectForKey:@"username"]];
        
        [UIView animateWithDuration:0.3 
                              delay:0.0 
                            options:UIViewAnimationCurveEaseInOut 
                         animations:^{
                             
                             self.sessionView.center = CGPointMake(self.sessionView.center.x,
                                                                   self.sessionView.center.y + self.sessionView.frame.size.height);
                             
                         } 
                         completion:^(BOOL finished) {
                             
                         }
         ];
    }
}

- (void)calculateContentSizeForScrollView
{
    CGFloat width = self.pagingScrollView.frame.size.width;
    //CGFloat height = self.pagingScrollView.frame.size.height;
    CGFloat height = 400.0;
    
    CGSize contentSize = CGSizeMake((width * smallDocuments.count), height);
    
    NSLog(@"PagingScrollView content size set to %f, %f",contentSize.width,contentSize.height);
    
    self.pagingScrollView.contentSize = contentSize;
}

- (void)setPagecount
{
    self.pageControl.numberOfPages = smallDocuments.count;
}

- (void)removeSmallDocument:(int)indexOfDocument
{
    // Get the screen Document file path
    SmallDocumentViewController *smallDoc = [smallDocuments objectAtIndex:indexOfDocument];
    
    NSString *filePath = smallDoc.documentFileUrl;
    
    [ScreenDocument deleteScreenDocumentWithFileName:filePath CompletionHandler:^(BOOL success) {
        if(success)
        {
            NSLog(@"%@ successfuly deleted");
        }else{
            NSLog(@"There was a problem deleting %@");
        }
    }];
    
    [smallDocuments removeObjectAtIndex:indexOfDocument];
    [self setRemoveButtonStatue];
    [self calculateContentSizeForScrollView];
    [self setPagecount];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.pagingScrollView.frame.size.width;
    int page = floor((self.pagingScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)setRemoveButtonStatue
{
    if(smallDocuments.count == 0)
    {
        self.removeButton.enabled = NO;
    }else{
        self.removeButton.enabled = YES;
    }
}

- (void)createNewDocument
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newDocumentProgressUpdated:) name:@"NewScreenDocumentProgressUpdate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newDocumentCreated:) name:@"NewScreenDocumentCreated" object:nil];
    
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progress.mode = MBProgressHUDModeAnnularDeterminate;
    progress.labelText = @"Creating New Screening";
    
    [ScreenDocument createScreenDocument];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ScreenDocumentToCandidate"]){
        UINavigationController *destNavController = (UINavigationController *)segue.destinationViewController;
        
        CandidateTableViewController *candidateTVC = (CandidateTableViewController *)[destNavController.viewControllers lastObject];
        
        if(selectedScreenDocument){
            NSLog(@"Setting screen document on CandidateTableViewController");
            candidateTVC.screenDoc = selectedScreenDocument;
        }else{
            NSLog(@"There was no selected screening, should not be seguing");
        }
    }
    
    if([segue.identifier isEqualToString:@"LoginModal"]){
        LoginModalViewController *loginModal = (LoginModalViewController *)[segue destinationViewController];
        loginModal.delegate = self;
    }
}

#pragma mark - IBActions

- (IBAction)newDocumentPressed:(id)sender{
    [TestFlight passCheckpoint:@"New Document Pressed"];
    
    if(![(AppDelegate *)[[UIApplication sharedApplication] delegate] session]){
        [self performSegueWithIdentifier:@"LoginModal" sender:self];
    }else{
    
        [self createNewDocument];
    }
}

- (IBAction)logoutPressed {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setSession:nil];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
       self.sessionView.center = CGPointMake(self.sessionView.center.x,
                                             self.sessionView.center.y - self.sessionView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

// TODO: Finish implementation
- (IBAction)removeDocumentPressed:(id)sender
{
    [TestFlight passCheckpoint:@"Remove Document Pressed"];
    
    // Animate out view from scrollview
    int indexOfDocument = self.pageControl.currentPage;
    SmallDocumentViewController *smallDocVC = [smallDocuments objectAtIndex:indexOfDocument];
    
    [UIView animateWithDuration:0.3 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseIn 
                     animations:^{
                         smallDocVC.view.center = CGPointMake(smallDocVC.view.center.x,1200.0);
                     } 
                     completion:^(BOOL finished) {
                         if(finished)
                         {
                             // Check if there are more documents after the deleted document
                             if((smallDocuments.count - 1) > indexOfDocument)
                             {
                                 // If there is, then iterate through those documents and moved them over
                                 for (int i = (indexOfDocument + 1); i < smallDocuments.count; i++) {
                                     SmallDocumentViewController *smallDoc = [smallDocuments objectAtIndex:i];
                                     [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                         smallDoc.view.center = CGPointMake(smallDoc.view.center.x - self.pagingScrollView.frame.size.width,smallDoc.view.center.y); 
                                     } completion:^(BOOL finished) {
                                         
                                     }];
                                 }
                                 
                                 [self removeSmallDocument:indexOfDocument];
                             }
                             // Check if this is the last document
                             else if((smallDocuments.count -1) == indexOfDocument){
                                 NSLog(@"Small Docs x is %f",smallDocVC.view.frame.origin.x);
                                 
                                 CGFloat x = self.pagingScrollView.contentOffset.x - self.pagingScrollView.frame.size.width;
                                 CGFloat y = 0.0;
                                 
                                 [UIView animateWithDuration:0.3 
                                                       delay:0.0 
                                                     options:UIViewAnimationCurveEaseInOut 
                                                  animations:^{
                                                      [self.pagingScrollView setContentOffset:CGPointMake(x, y) animated:NO];
                                                  } 
                                                  completion:^(BOOL finished) {
                                                      [self removeSmallDocument:indexOfDocument];
                                                  }
                                  ];
                                 
                                 
                             }
                         }
                     }
    ];
    
    // Remove view from array
    
    // Delete document from filesystem
}

#pragma mark - Notification Observers

- (void)newDocumentProgressUpdated:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    NSLog(@"Progress Updated: %f",[(NSNumber *)[userInfo objectForKey:@"progress"] floatValue]);
    
    progress.progress = [(NSNumber *)[userInfo objectForKey:@"progress"] floatValue];
}

- (void)newDocumentCreated:(NSNotification *)notification
{
    progress.progress = 1.0;
    
    [TestFlight passCheckpoint:@"Notification received that new document has been created"];
    
    NSLog(@"New Document created, transistion to candidate view");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NewScreenDocumentProgressUpdate" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NewScreenDocumentCreated" object:nil];
    
    selectedScreenDocument = (ScreenDocument *)notification.object;
    
    [progress hide:YES];
    
    [self performSegueWithIdentifier:@"ScreenDocumentToCandidate" sender:nil];
}

- (void)documentOpened:(NSNotification *)notification
{
    [TestFlight passCheckpoint:@"ScreenDocumentViewController notified that document was opened"];
    selectedSmallDoc.progressView.progress = 0.95;
    
    ScreenDocument *screenDoc = (ScreenDocument *)notification.object;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ScreenDocumentOpened" object:nil];
    
    if(screenDoc){
        NSLog(@"ScreenDocument was opened and was not nil");
        // Set screenDoc as selected screen doc
        selectedScreenDocument = screenDoc;
        selectedSmallDoc.progressView.progress = 1.0;
        // Perform segue
        [self performSegueWithIdentifier:@"ScreenDocumentToCandidate" sender:self];
    }else{
        NSLog(@"There was an error opening the screen document");
        // screenDoc was nil, present a message
        
    }
}

#pragma mark - Small Document Delegate Protocal

- (void)documentWasTapped:(NSString *)documentFilename Sender:sender
{
    [TestFlight passCheckpoint:@"User opened a document"];
    // Show some kind of actiivity indicator
    SmallDocumentViewController *smallDocSender = (SmallDocumentViewController *)sender;
    selectedSmallDoc = smallDocSender;
    selectedSmallDoc.progressView.hidden = NO;
    selectedSmallDoc.progressView.progress = 0.5;
    
    // Set up notification listener
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(documentOpened:) 
                                                 name:@"ScreenDocumentOpened" 
                                               object:nil];
    
    [ScreenDocument openDocumentWithFileName:documentFilename];
}

#pragma mark - Login Modal Delegate Protocal
- (void)loginDidFinishWithUsername:(NSString *)username EventName:(NSString *)eventName Sender:(id)sender
{
    LoginModalViewController *loginModal = (LoginModalViewController *)sender;
    loginModal.delegate = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSDictionary *sessionData = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",eventName,@"eventName", nil];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] setSession:sessionData];
        
        [self createNewDocument];
    }];
    
}
@end
