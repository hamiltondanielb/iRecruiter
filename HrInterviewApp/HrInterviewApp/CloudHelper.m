//
//  CloudHelper.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CloudHelper.h"

@implementation CloudHelper

@synthesize document = _document;

+ (NSURL *)localFileUrl
{
    
    NSURL *localFile = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    localFile = [localFile URLByAppendingPathComponent:SharedFileName];
    
    return localFile;
}
@end
