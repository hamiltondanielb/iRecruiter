//
//  Location+Factory.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@interface Location (Factory)

+ (Location *)locationWithName:(NSString *)name Context:(NSManagedObjectContext *)context;

@end
