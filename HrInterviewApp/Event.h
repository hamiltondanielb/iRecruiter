//
//  Event.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Screening;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *screenings;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addScreeningsObject:(Screening *)value;
- (void)removeScreeningsObject:(Screening *)value;
- (void)addScreenings:(NSSet *)values;
- (void)removeScreenings:(NSSet *)values;

@end
