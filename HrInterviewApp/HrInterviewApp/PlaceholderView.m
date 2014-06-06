//
//  PlaceholderView.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlaceholderView.h"

@implementation PlaceholderView

@synthesize messageText = _messageText;

- (id)initWithFrame:(CGRect)frame MessageText:(NSString *)messageText
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        _messageText = messageText;
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = messageText;
       
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.font = [UIFont systemFontOfSize:20.0];
         [messageLabel sizeToFit];
        messageLabel.textAlignment = UITextAlignmentCenter;
        messageLabel.center = CGPointMake((self.frame.size.width / 2),(self.frame.size.height / 2)-40);
        [self addSubview:messageLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
