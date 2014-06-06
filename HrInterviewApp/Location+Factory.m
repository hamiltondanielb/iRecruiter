//
//  Location+Factory.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location+Factory.h"

@implementation Location (Factory)

+ (Location *)locationWithName:(NSString *)name Context:(NSManagedObjectContext *)context
{
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
    
    return location;
}

@end
