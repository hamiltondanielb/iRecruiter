//
//  Candidate.h
//  HrInterviewApp
//
//  Created by Scott on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Major, Screening, TechnicalQuestion, TechnicalSkill;

@interface Candidate : NSManagedObject

@property (nonatomic, retain) NSNumber * communicationSkill;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSDate * graduationDate;
@property (nonatomic, retain) NSNumber * hot;
@property (nonatomic, retain) NSNumber * majorGpa;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * overallGpa;
@property (nonatomic, retain) NSNumber * sponsorshipNeeded;
@property (nonatomic, retain) NSString * teamPreference;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Major *major;
@property (nonatomic, retain) NSSet *questions;
@property (nonatomic, retain) Screening *screening;
@property (nonatomic, retain) NSSet *technicalSkills;
@end

@interface Candidate (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(TechnicalQuestion *)value;
- (void)removeQuestionsObject:(TechnicalQuestion *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

- (void)addTechnicalSkillsObject:(TechnicalSkill *)value;
- (void)removeTechnicalSkillsObject:(TechnicalSkill *)value;
- (void)addTechnicalSkills:(NSSet *)values;
- (void)removeTechnicalSkills:(NSSet *)values;

@end
