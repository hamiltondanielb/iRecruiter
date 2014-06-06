//
//  PreferredLocation.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PreferredLocation : NSObject <MKAnnotation> {
    NSString *_name;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate;

@end