//
//  Screening.h
//  HrInterviewApp
//
//  Created by Scott on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate, Event;

@interface Screening : NSManagedObject

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * screener;
@property (nonatomic, retain) Candidate *candidate;
@property (nonatomic, retain) Event *event;

@end
