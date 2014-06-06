//
//  Major.h
//  HrInterviewApp
//
//  Created by Scott on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate, TechnicalQuestion;

@interface Major : NSManagedObject

@property (nonatomic, retain) NSString * college;
@property (nonatomic, retain) NSString * majorDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * levelOfEducation;
@property (nonatomic, retain) NSSet *candidates;
@property (nonatomic, retain) NSSet *technicalQuestions;
@end

@interface Major (CoreDataGeneratedAccessors)

- (void)addCandidatesObject:(Candidate *)value;
- (void)removeCandidatesObject:(Candidate *)value;
- (void)addCandidates:(NSSet *)values;
- (void)removeCandidates:(NSSet *)values;

- (void)addTechnicalQuestionsObject:(TechnicalQuestion *)value;
- (void)removeTechnicalQuestionsObject:(TechnicalQuestion *)value;
- (void)addTechnicalQuestions:(NSSet *)values;
- (void)removeTechnicalQuestions:(NSSet *)values;

@end
