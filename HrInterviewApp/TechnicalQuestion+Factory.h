//
//  TechnicalQuestion+Factory.h
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TechnicalQuestion.h"

@interface TechnicalQuestion (Factory)

+ (TechnicalQuestion *)technicalQuestionWithText:(NSString *)text Context:(NSManagedObjectContext *)context;

@end
