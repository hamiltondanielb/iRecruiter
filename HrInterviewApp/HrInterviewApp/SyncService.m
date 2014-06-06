//
//  SyncService.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyncService.h"

@implementation SyncService

+ (void)fetchDataFromWebService
{
    // Make web request for data here and store it in the database
    
//    _document = [[ScreenDocument sharedInstance] document];
//    NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    fileUrl = [fileUrl URLByAppendingPathComponent:TemplateFilename];
//    
//    ScreenDocument *screenDocument = [[ScreenDocument alloc] initWithFileURL:fileUrl];
//    
//    if([[NSFileManager defaultManager] fileExistsAtPath:[screenDocument.fileURL path]]){
//        NSLog(@"Template exists, overwriting");
//        [screenDocument saveToURL:screenDocument.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
//            if (success) NSLog(@"Document saved with seed data");
//            if (!success) NSLog(@"Document couldn't be saved");
//        }];
//    }else{
//        NSLog(@"Template does not exist, creating");
//        [screenDocument saveToURL:screenDocument.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
//            if (success) NSLog(@"Document saved with seed data");
//            if (!success) NSLog(@"Document couldn't be saved");
//        }];
//    }
//    
//    [screenDocument openWithCompletionHandler:^(BOOL success) {
//        if(success){
//            Major *major1 = [Major majorWithName:@"Computer Science" College:@"Technology" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *csQuestion1 = [TechnicalQuestion technicalQuestionWithText:@"What are metaphors used for in functional design? Can you name some successful examples?" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *csQuestion2 = [TechnicalQuestion technicalQuestionWithText:@"How can you reduce the user's perception of waiting when some functions take a lot of time?" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *csQuestion3 = [TechnicalQuestion technicalQuestionWithText:@"Which controls would you use when a user must select multiple items from a big list, in a minimal amount of space?" Context:screenDocument.managedObjectContext];
//            
//            major1.technicalQuestions = [NSSet setWithObjects:csQuestion1, csQuestion2, csQuestion3, nil];
//            
//            Major *major2 = [Major majorWithName:@"Information Systems" College:@"Media Arts and Science" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *isQuestion1 = [TechnicalQuestion technicalQuestionWithText:@"How many of the three variables scope, time and cost can be fixed by the customer?" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *isQuestion2 = [TechnicalQuestion technicalQuestionWithText:@"Who should make estimates for the effort of a project? Who is allowed to set the deadline?" Context:screenDocument.managedObjectContext];
//            
//            TechnicalQuestion *isQuestion3 = [TechnicalQuestion technicalQuestionWithText:@"o you prefer minimization of the number of releases or minimization of the amount of work-in-progress?" Context:screenDocument.managedObjectContext];
//            
//            major2.technicalQuestions = [NSSet setWithObjects:isQuestion1,isQuestion2,isQuestion3, nil];
//            
//            [Location locationWithName:@"Indianapolis, IN" Context:screenDocument.managedObjectContext];
//            [Location locationWithName:@"Denver, CO" Context:screenDocument.managedObjectContext];
//            [Location locationWithName:@"Los Angles, CA" Context:screenDocument.managedObjectContext];
//            
//            
//            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Major"];
//            NSManagedObjectContext *context =  screenDocument.managedObjectContext;
//            
//            NSError *error;
//            NSArray *majorArray = [context executeFetchRequest:request error:&error];
//            
//            NSLog(@"Loaded %d majors",[majorArray count]);
//        }
//        }];
    
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",TemplateFilename]];
    
    NSString *json = @"{\"Major\": [ { \"Name\":  \"CS\", \"College\": \"Technology\", \"TechnicalQuestion\": [ {  \"Question\": \"What are metaphors used for  in functional design? Can you name some  successful examples?\" }, {  \"Question\": \"How can you  reduce the user's perception of  waiting when some functions  take a lot of  time?\" }, {\"Question\": \"Which controls would you  use when a user must select multiple items from  a big list, in a minimal amount of space?\" }  ] }, { \"Name\": \"IS\", \"College\": \"Business\", \"TechnicalQuestion\": [  { \"Question\": \"How many of the three variables  scope, time and cost can be fixed by  the customer?\" }, {\"Question\": \"Who should make estimates for the effort of a project? Who is  allowed to set the deadline?\" } ] } ], \"Location\": [ { \"Name\": \"Indianapolis, IN\",\"Latitude\":39.768997,\"Longitude\":-86.157961},{\"Name\":\"Irvine, CA\",\"Latitude\":33.684639,\"Longitude\":-117.80056},{\"Name\":\"Denver,CO\",\"Latitude\":39.749434,\"Longitude\":-104.981232}], \"TechnicalSkill\":[{\"Name\":\"C#\"},{\"Name\":\"Java\"}]}";
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
    
    NSString *pListError;
    
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:jsonDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&pListError];
    
    // check is plistData exists
    if(plistData)
    {
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"Error in saveData: %@", pListError);
    }
    
}

@end
