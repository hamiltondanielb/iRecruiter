//
//  SyncService.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TechnicalQuestion.h"
#import "TechnicalQuestion+Factory.h"
#import "Major.h"
#import "Major+Factory.h"
#import "Location+Factory.h"
#import "ScreenDocument.h"

@interface SyncService : NSObject

+ (void)fetchDataFromWebService;

@end
