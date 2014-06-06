//
//  ScreenDocument.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudHelper.h"
#import "Location.h"
#import "Candidate.h"
#import "Major.h"
#import "TechnicalSkill.h"
#import "Response.h"
#import "Screening.h"

//NSString *const HRNewScreenDocumentNotification = @"HRNewScreenDoucmentNotification";

@interface ScreenDocument : UIManagedDocument

+ (void)createScreenDocument;
+ (void)openDocumentWithFileName:(NSString *)filename;
+ (void)deleteScreenDocumentWithFileName:(NSString *)filename CompletionHandler:(void (^)(BOOL success))completionHandler;

@end