//
//  GradDateViewController.h
//  HrInterviewApp
//
//  Created by Dan Hamilton on 6/20/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradDateViewController;
@protocol GradDateDelegate <NSObject>

@required
-(void)gradDateSelected:(NSDate *)gradDate;

@end

@interface GradDateViewController : UIViewController
{
    id<GradDateDelegate> delegate;
}

- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *gradDatePicker;

@property (strong,nonatomic) NSDate * selectedValue;
@property (strong,nonatomic) id<GradDateDelegate> delegate;
@end