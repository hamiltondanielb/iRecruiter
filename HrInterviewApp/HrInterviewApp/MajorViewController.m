//
//  MajorViewController.m
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/18/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "MajorViewController.h"

@interface MajorViewController ()

@end

@implementation MajorViewController

@synthesize majorPicker;
@synthesize delegate;
@synthesize selectedValue = _selectedValue;
@synthesize majorArray = _majorArray;

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
    
    self.contentSizeForViewInPopover = CGSizeMake(250.0,200.0);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"MajorViewController loaded with %d items in majorArray",self.majorArray.count);
    
    if(self.majorArray.count > 0 && self.selectedValue){
        [majorPicker selectRow:[self.majorArray indexOfObject:self.selectedValue] inComponent:0 animated:NO];
    }else{
        NSLog(@"There was no entries in majorArray to load");
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.majorArray objectAtIndex:row]name];
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.majorArray count];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (void)viewDidUnload
{
    [self setMajorPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self.delegate majorWasSelected:[self.majorArray objectAtIndex:[majorPicker selectedRowInComponent:0]]];
}

@end
