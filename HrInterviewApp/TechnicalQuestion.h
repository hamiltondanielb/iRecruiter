//
//  TechnicalQuestion.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate, Major, Response;

@interface TechnicalQuestion : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Major *major;
@property (nonatomic, retain) Candidate *candidate;
@property (nonatomic, retain) Response *response;

@end
