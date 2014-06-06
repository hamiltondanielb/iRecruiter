//
//  SmallDocumentViewController.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SmallDocumentViewController;

@protocol SmallDocumentDelegate <NSObject>

@required
- (void)documentWasTapped:(NSString *)documentFilename Sender:(id)sender;
@end

@interface SmallDocumentViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic,weak) IBOutlet UIImageView *documentImageView;
@property (nonatomic,weak) IBOutlet UILabel *documentLabel;
@property (nonatomic,weak) IBOutlet UIProgressView *progressView;
@property (nonatomic,strong) id <SmallDocumentDelegate> delegate;
@property (nonatomic,strong) NSString *documentFileUrl;

@end
