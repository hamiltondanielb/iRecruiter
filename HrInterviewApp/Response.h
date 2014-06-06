//
//  Response.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TechnicalQuestion;

@interface Response : NSManagedObject

@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) TechnicalQuestion *technicalQuestion;

@end
