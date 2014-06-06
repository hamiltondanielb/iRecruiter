//
//  ShadowTableHeaderView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/9/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadowTableHeaderView : UIView
{
    UILabel *_titleLabel;
    UIColor *_lightColor;
    UIColor *_darkColor;
    CGRect _coloredBoxRect;
    CGRect _topPaperRect;
    CGRect _paperRect;
}

@property (retain) UILabel *titleLabel;
@property (retain) UIColor *lightColor;
@property (retain) UIColor *darkColor;

@end
