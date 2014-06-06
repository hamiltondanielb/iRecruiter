//
//  ScreenDocumentViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/2/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallDocumentViewController.h"
#import "PagingScrollViewWrapperView.h"
#import "CandidateTableViewController.h"
#import "ScreenDocument.h"
#import "MBProgressHUD.h"
#import "LoginModalViewController.h"

@interface ScreenDocumentViewController : UIViewController <UIScrollViewDelegate, SmallDocumentDelegate, LoginModalDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *pagingScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet PagingScrollViewWrapperView *pagingWrapperView;
@property (nonatomic, weak) IBOutlet UIView *sessionView;
@property (nonatomic, weak) IBOutlet UIButton *removeButton;
@property (nonatomic, weak) IBOutlet UIButton *logoutButton;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

- (IBAction)newDocumentPressed:(id)sender;
- (IBAction)logoutPressed;
- (IBAction)removeDocumentPressed:(id)sender;
@end
