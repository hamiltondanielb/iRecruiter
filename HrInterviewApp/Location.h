//
//  Location.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *candidates;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addCandidatesObject:(Candidate *)value;
- (void)removeCandidatesObject:(Candidate *)value;
- (void)addCandidates:(NSSet *)values;
- (void)removeCandidates:(NSSet *)values;

@end
