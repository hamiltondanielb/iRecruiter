//
//  ShadowTableFooterView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadowTableFooterView : UIView
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

@end
