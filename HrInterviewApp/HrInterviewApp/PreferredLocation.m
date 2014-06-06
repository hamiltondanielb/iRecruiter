//
//  PreferredLocation.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferredLocation.h"

@implementation PreferredLocation

@synthesize name = _name;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return @"";
}

@end
