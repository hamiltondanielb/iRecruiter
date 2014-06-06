//
//  Major+Factory.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Major+Factory.h"

@implementation Major (Factory)

+ (Major *)majorWithName:(NSString *)name College:(NSString *)college Context:(NSManagedObjectContext *)context{
    Major *major = [NSEntityDescription insertNewObjectForEntityForName:@"Major" inManagedObjectContext:context];
    major.name = name;
    major.college = college;
    
    return major;
}

@end
