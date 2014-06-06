//
//  MajorViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/18/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Major.h"

@class MajorViewController;

@protocol MajorDelegate <NSObject>

@required
- (void)majorWasSelected:(Major *)major;

@end

@interface MajorViewController : UIViewController
{
    id <MajorDelegate> delegate;
}
@property (weak, nonatomic) IBOutlet UIPickerView *majorPicker;
@property (strong, nonatomic) Major *selectedValue;
@property (strong, nonatomic) id <MajorDelegate> delegate;
@property (strong, nonatomic) NSArray *majorArray;

- (IBAction)doneButtonPressed:(id)sender;
@end
