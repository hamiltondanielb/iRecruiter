//
//  TechnicalSkill.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate;

@interface TechnicalSkill : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *candidates;
@end

@interface TechnicalSkill (CoreDataGeneratedAccessors)

- (void)addCandidatesObject:(Candidate *)value;
- (void)removeCandidatesObject:(Candidate *)value;
- (void)addCandidates:(NSSet *)values;
- (void)removeCandidates:(NSSet *)values;

@end
