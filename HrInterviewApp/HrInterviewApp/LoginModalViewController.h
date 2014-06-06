//
//  LoginModalViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginModalViewController;

@protocol LoginModalDelegate <NSObject, UITextFieldDelegate>

-(void)loginDidFinishWithUsername:(NSString *)username EventName:(NSString *)eventName Sender:(id)sender;

@end

@interface LoginModalViewController : UIViewController
{
    id <LoginModalDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *eventNameTextField;
@property (nonatomic, retain) id delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;


- (IBAction)startScreening:(id)sender;
- (IBAction)dismissModal:(id)sender;

@end
