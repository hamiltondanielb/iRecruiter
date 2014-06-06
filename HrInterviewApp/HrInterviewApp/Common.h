//
//  Common.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
CGRect rectFor1PxStroke(CGRect rect);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);

@end
