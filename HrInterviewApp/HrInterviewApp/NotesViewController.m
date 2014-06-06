//
//  RecruitingTestViewController.m
//  RecruitingTest
//
//  Created by Scott on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotesViewController.h"

@implementation NotesViewController
{
    
}

@synthesize notesTextView = _notesTextView;
@synthesize screening = _screening;

// Used to pass data to next view controller using segue identifiers
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"Source Controller = %@", [segue sourceViewController]);
    NSLog(@"Destination Controller = %@", [segue destinationViewController]);
    NSLog(@"Segue Identifier = %@", [segue identifier]);
    
    if([segue.identifier isEqualToString:@"PushReview"]){
        ReviewTableViewController *reviewVC = (ReviewTableViewController *)[segue destinationViewController];
        reviewVC.screening = self.screening;
    }
}

#pragma mark - Pregenerated code

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Candidate"];
    NSError *error;
    NSArray *candidateArray = [self.screening.managedObjectContext executeFetchRequest:request error:&error];
    
    NSLog(@"There are %d candidates",candidateArray.count);
}

- (void)viewDidUnload
{
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
    [_notesTextView becomeFirstResponder];
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
    // Return YES for supported orientations
    return YES;
}
@end
