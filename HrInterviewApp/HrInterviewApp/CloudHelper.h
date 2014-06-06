//
//  CloudHelper.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudHelper : NSObject

@property (strong, nonatomic) UIManagedDocument *document;

+ (NSURL *)localFileUrl;

@end
