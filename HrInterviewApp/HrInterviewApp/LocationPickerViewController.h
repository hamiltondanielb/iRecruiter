//
//  LocationPickerViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/18/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@class LocationPickerViewController;
@protocol LocationDelegate <NSObject>

@required
-(void)locationWasSelected: (Location *)location;

@end

@interface LocationPickerViewController : UIViewController
{
    id<LocationDelegate> delegate;
}
@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (strong,nonatomic) Location *selectedValue;
@property (strong,nonatomic) id <LocationDelegate> delegate;
@property (strong, nonatomic) NSArray *locationArray;

- (IBAction)doneButtonPressed:(id)sender;

@end