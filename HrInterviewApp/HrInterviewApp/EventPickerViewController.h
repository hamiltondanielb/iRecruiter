//
//  EventPickerViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/29/12.
//
//

#import <UIKit/UIKit.h>

@protocol EventPickerDelegate <NSObject>

@required
- (void)eventPickerDidPickEvent:(NSString *)eventName;

@end

@interface EventPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    id <EventPickerDelegate> delegate;
}

@property (nonatomic,weak) UIPickerView *eventPicker;
@property (nonatomic,strong) id delegate;

- (IBAction)tapGestureHandler:(id)sender;

@end
