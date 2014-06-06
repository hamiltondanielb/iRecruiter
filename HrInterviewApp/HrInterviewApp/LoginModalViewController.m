//
//  LoginModalViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginModalViewController.h"

@implementation LoginModalViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize eventNameTextField = _eventNameTextField;
@synthesize delegate = _delgate;
@synthesize nameLabel = _nameLabel;
@synthesize eventLabel = _eventLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Bring focus to UserNameTextField
    [self.usernameTextField becomeFirstResponder];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"seamlesstexture11_1200.png"]];
}

#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Jump to EventNameTextField if they hit return in UserNameTextField
    if(textField == _usernameTextField)
    {
        [self.eventNameTextField becomeFirstResponder];
    }
    
    // Start screening if they hit return on the EventNameTextField
    if(textField == _eventNameTextField)
    {
        [self startScreening:self];
        return NO;
    }
    return NO;
}

#pragma IBActions

-(IBAction)startScreening:(id)sender
{
    //[self.view endEditing:YES];
    //[self.usernameTextField resignFirstResponder];
    //[self.eventNameTextField resignFirstResponder];
    
    // Validate entry
    if (self.usernameTextField.text.length < 1)
    {
        self.nameLabel.textColor = [UIColor redColor];
        if (self.eventNameTextField.text.length < 1)
        {
            self.eventLabel.textColor = [UIColor redColor];
        }
        return;
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    if (self.eventNameTextField.text.length < 1)
    {
        self.eventLabel.textColor = [UIColor redColor];
        if (self.usernameTextField.text.length < 1)
        {
            self.nameLabel.textColor = [UIColor redColor];
        }
        return;
    }
    else
    {
        self.eventLabel.textColor = [UIColor blackColor];
    }
    
    
    // Send message to delegate passing along username and event name
    NSString *username = _usernameTextField.text;
    NSString *eventName = _eventNameTextField.text;
    
    [self.delegate loginDidFinishWithUsername:username EventName:eventName Sender:self];
}

- (IBAction)dismissModal:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setNameLabel:nil];
    [self setEventLabel:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
@end
