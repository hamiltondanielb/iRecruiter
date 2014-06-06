//
//  Major+Factory.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Major.h"

@interface Major (Factory)

+ (Major *)majorWithName:(NSString *)name College:(NSString *)college Context:(NSManagedObjectContext *)context;

@end
