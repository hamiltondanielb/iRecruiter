//
//  GradDateViewController.m
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/20/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "GradDateViewController.h"

@interface GradDateViewController ()

@end

@implementation GradDateViewController
@synthesize gradDatePicker;
@synthesize delegate;
@synthesize selectedValue =_selectedValue;

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
	// Do any additional setup after loading the view.
//    
    self.contentSizeForViewInPopover = CGSizeMake(350.0,200.0);
}

- (void)viewDidUnload
{
    [self setGradDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)doneButtonPressed:(id)sender 
{

    [self.delegate gradDateSelected:self.gradDatePicker.date];
}
@end
