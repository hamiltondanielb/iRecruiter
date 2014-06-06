//
//  PlaceholderView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderView : UIView

@property (strong, nonatomic) NSString *messageText;

- (id)initWithFrame:(CGRect)frame MessageText:(NSString *)messageText;

@end
