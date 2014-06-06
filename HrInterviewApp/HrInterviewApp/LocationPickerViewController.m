//
//  LocationPickerViewController.m
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/18/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "LocationPickerViewController.h"

@interface LocationPickerViewController ()

@end

@implementation LocationPickerViewController
@synthesize locationPicker;
@synthesize locationArray = _locationArray;
@synthesize delegate;
@synthesize selectedValue = _selectedValue;

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
    
    NSLog(@"LocationPickerViewController loaded with %d items in locationArray",self.locationArray.count);
    NSLog(@"Selected Location is %@",self.selectedValue.name);
    
    if(self.locationArray.count > 0 && self.selectedValue){
        NSLog(@"Index of item in array: %d",[self.locationArray indexOfObject:self.selectedValue]);
        
        [locationPicker selectRow:[self.locationArray indexOfObject:self.selectedValue] inComponent:0 animated:NO];
    }else{
        NSLog(@"locationArray had a count of 0 or less, could not set a value");
    }
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.locationArray objectAtIndex:row]name];;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.locationArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (void)viewDidUnload
{
    [self setLocationPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(id)sender
{
    //TODO: WHY and WHAT this is doing.
    [self.delegate locationWasSelected:[self.locationArray objectAtIndex:[locationPicker selectedRowInComponent:0]]];
}
@end
