//
//  ShadowView.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadowView : UIView

@property (nonatomic,strong) NSNumber *shadowOpacity;
@property (nonatomic,strong) NSNumber *shadowRadius;
@property (nonatomic,strong) NSNumber *xOffset;
@property (nonatomic,strong) NSNumber *yOffset;

@end
