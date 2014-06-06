//
//  TechnicalQuestion+Factory.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TechnicalQuestion+Factory.h"

@implementation TechnicalQuestion (Factory)

+ (TechnicalQuestion *)technicalQuestionWithText:(NSString *)text Context:(NSManagedObjectContext *)context{
    TechnicalQuestion *question = [NSEntityDescription insertNewObjectForEntityForName:@"TechnicalQuestion" inManagedObjectContext:context];
    question.text = text;
    
    return question;
}

@end
