//
//  Team.h
//  HrInterviewApp
//
//  Created by Scott on 8/3/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Candidate;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * teamDescription;
@property (nonatomic, retain) NSNumber * teamId;
@property (nonatomic, retain) NSSet *candidates;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addCandidatesObject:(Candidate *)value;
- (void)removeCandidatesObject:(Candidate *)value;
- (void)addCandidates:(NSSet *)values;
- (void)removeCandidates:(NSSet *)values;

@end
