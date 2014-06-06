//
//  Candidate+Factory.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/21/12.
//  Copyright (c) 2012 Interactive Intelligence. All rights reserved.
//

#import "Candidate+Factory.h"

@implementation Candidate (Factory)

- (void)populateTechnicalQuestions{
    NSLog(@"Populating candidate with questions");
    Major *major = self.major;
    
    if(major){
        
        for (TechnicalQuestion *question in major.technicalQuestions) {
            
            TechnicalQuestion *newQuesiton = question;
            [self addQuestionsObject:newQuesiton];
        }
    }
    
}

@end
