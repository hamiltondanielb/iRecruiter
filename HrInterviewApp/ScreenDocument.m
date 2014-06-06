//
//  ScreenDocument.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScreenDocument.h"


@interface ScreenDocument()

@end

@implementation ScreenDocument

#pragma mark Class Methods

+ (void)createScreenDocument
{
    // Get the directory for Documents
    NSURL *localFile = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // Check if session data exists, use that for file name
    
    NSDictionary *sessionData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] session];
    NSString *eventName = [sessionData objectForKey:@"eventName"];
    
    // Add filename to path
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMddyyyyhhmmSS"];
    NSString *filename = [dateFormat stringFromDate:now];
    
    if(eventName)
    {    
        filename = eventName; 
    }
    
    filename = [NSString stringWithFormat:@"%@ 1.screening",filename];
        
    NSURL *templocalFile = [localFile URLByAppendingPathComponent:filename];
    
    while([[NSFileManager defaultManager] fileExistsAtPath:templocalFile.path]){
        NSLog(@"File exists already, incrementing file number");
        NSString *subString = @"";
        
        NSScanner *scanner = [NSScanner scannerWithString:filename];
        [scanner scanUpToString:@" " intoString:nil]; // Scan all characters before #
        if(![scanner isAtEnd]) {
            [scanner scanString:@" " intoString:nil]; // Scan the # character
            [scanner scanUpToString:@"." intoString:&subString];
        }
        
        NSNumber *fileVersionNumber = [NSNumber numberWithInt:([subString intValue] + 1)];
        filename = [NSString stringWithFormat:@"%@ %i.screening",eventName,[fileVersionNumber intValue]];
        templocalFile = [localFile URLByAppendingPathComponent:filename];
    }
    
    localFile = templocalFile;
    
    NSLog(@"Using %@ as file path",localFile);
    
    // Intialize the document
    ScreenDocument *screenDoc = [[ScreenDocument alloc] initWithFileURL:localFile];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    screenDoc.persistentStoreOptions = options;
    
    // Save the document to the file path
    [screenDoc saveToURL:localFile 
        forSaveOperation:UIDocumentSaveForCreating 
       completionHandler:^(BOOL success) {
           if(success)
           {
               [TestFlight passCheckpoint:@"New Document Saved"];
               NSLog(@"%@ was saved!",[[screenDoc fileURL] path]);
               
               // Check the state of the document, needs to be opened before we
               // can do anything to it
               if(screenDoc.documentState == UIDocumentStateClosed){
                   [TestFlight passCheckpoint:@"New Document Opening"];
                   
                   [screenDoc openWithCompletionHandler:^(BOOL success) {
                       if(success){ 
                           [TestFlight passCheckpoint:@"New Docuemnt opened"];
                           [self seedScreenDocument:screenDoc];
                       }else{
                           [TestFlight passCheckpoint:@"New Docuemnt failed to open"];
                           NSLog(@"Could not open screen doc %@",screenDoc.fileURL.path);
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocument" object:nil];
                       }
                   }];
               }else if(screenDoc.documentState == UIDocumentStateNormal){
                   // Send update with progress
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentProgressUpdate" object:screenDoc userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.25],@"progress", nil]];
                   
                   [self seedScreenDocument:screenDoc];
               }
           }else{
               [TestFlight passCheckpoint:@"Document ouldn't be saved"];
               
               NSLog(@"Could not save new screen doc at path %@",screenDoc.fileURL.path);
               
               [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocument" object:nil];
           }
    }];
}
   
+ (void)seedScreenDocument:(ScreenDocument *)screenDoc
{
    [TestFlight passCheckpoint:@"Seeding document"];
    NSLog(@"Seeding %@",screenDoc.fileURL.path);
    
    // Data.plist code
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",TemplateFilename]];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:TemplateFilename ofType:@"plist"];
    }
    
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    // convert static property liost into dictionary object
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    
    if (!temp)
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    NSArray *locationsArray = (NSArray *)[temp objectForKey:@"Location"];
    NSArray *majorsArray = (NSArray *)[temp objectForKey:@"Major"];
    NSArray *techSkillsArray = (NSArray *)[temp objectForKey:@"TechnicalSkill"];
    
    // Get event data from Session
    
    NSDictionary *sessionData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] session];
    NSString *username = [sessionData objectForKey:@"username"];
    
    Screening *screening = [NSEntityDescription insertNewObjectForEntityForName:@"Screening" inManagedObjectContext:screenDoc.managedObjectContext];
    screening.screener = username;
    
    for (NSDictionary *locationEntry in locationsArray)
    {
        Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:screenDoc.managedObjectContext];
        location.name = [locationEntry valueForKey:@"Name"];
        
        location.longitude = [locationEntry valueForKey:@"Longitude"];
        location.latitude = [locationEntry valueForKey:@"Latitude"];
    }
    
    [TestFlight passCheckpoint:@"Locations loaded into document"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentProgressUpdate" object:screenDoc userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.50],@"progress", nil]];
    
    for (NSDictionary *majorEntry in majorsArray)
    {
        Major *major = [NSEntityDescription insertNewObjectForEntityForName:@"Major" inManagedObjectContext:screenDoc.managedObjectContext];
        major.name = (NSString *)[majorEntry valueForKey:@"Name"];
        
        NSArray *technicalQuestionsArray = (NSArray *)[majorEntry objectForKey:@"TechnicalQuestion"];
        for (NSDictionary *technicalQuestionEntry in technicalQuestionsArray) {
            TechnicalQuestion *techQuestion = [NSEntityDescription insertNewObjectForEntityForName:@"TechnicalQuestion" inManagedObjectContext:screenDoc.managedObjectContext];
            techQuestion.text = (NSString *)[technicalQuestionEntry valueForKey:@"Question"];
            
            Response *responseEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Response" inManagedObjectContext:screenDoc.managedObjectContext];
            
            techQuestion.response = responseEntry;
            
            responseEntry.value = [NSNumber numberWithInt:1];
            
            [major addTechnicalQuestionsObject:techQuestion];
        }
    }
    
    [TestFlight passCheckpoint:@"Majors loaded into document"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentProgressUpdate" object:screenDoc userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.75],@"progress", nil]];
    
    for (NSDictionary *techSkillEntry in techSkillsArray) {
        TechnicalSkill *techSkill = [NSEntityDescription insertNewObjectForEntityForName:@"TechnicalSkill" inManagedObjectContext:screenDoc.managedObjectContext];
        techSkill.name = (NSString *)[techSkillEntry objectForKey:@"Name"];
    }
    
    [TestFlight passCheckpoint:@"Tech Skills loaded into document"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentProgressUpdate" object:screenDoc userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0.95],@"progress", nil]];
    
    // Adding default candidate information
    Candidate *candidate = [NSEntityDescription insertNewObjectForEntityForName:@"Candidate" inManagedObjectContext:screenDoc.managedObjectContext];
    
    // Add candidate to screening
    screening.candidate = candidate;
    
    candidate.sponsorshipNeeded = NO;
    candidate.name = @"";
    
    NSError *error;
    NSFetchRequest *fetchMajors = [NSFetchRequest fetchRequestWithEntityName:@"TechnicalQuestion"];
    NSArray *technicalQuestion = [screenDoc.managedObjectContext executeFetchRequest:fetchMajors error:&error];
    
    if(error)
        NSLog(@"ERROR: %@",error);
    
    error = nil;
    
    NSFetchRequest *fetchLocations = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSArray *locations = [screenDoc.managedObjectContext executeFetchRequest:fetchLocations error:&error];
    
    if(error)
        NSLog(@"ERROR: %@",error);
    
    error = nil;
    
    NSFetchRequest *fetchTechSkill = [NSFetchRequest fetchRequestWithEntityName:@"TechnicalSkill"];
    NSArray *techSkills = [screenDoc.managedObjectContext executeFetchRequest:fetchTechSkill error:&error];
    
    if(error)
        NSLog(@"ERROR: %@",error);
    
    NSLog(@"%d tech skills loaded",techSkills.count);
    
    NSLog(@"%d locations loaded",locations.count);
    NSLog(@"%d technical questions found",technicalQuestion.count);
    
    NSLog(@"Finished seeding document");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentProgressUpdate" object:screenDoc userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0],@"progress", nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewScreenDocumentCreated" object:screenDoc];
}

+ (void)openDocumentWithFileName:(NSString *)filename
{
    NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    fileUrl = [fileUrl URLByAppendingPathComponent:filename];
    
    ScreenDocument *screenDocument = [[ScreenDocument alloc] initWithFileURL:fileUrl];
    [screenDocument openWithCompletionHandler:^(BOOL success){
        if(success)
        {
            NSLog(@"Document was opened - %@",filename);
            if([screenDocument documentState] == UIDocumentStateNormal){
                [TestFlight passCheckpoint:@"ScreenDocument Opened"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ScreenDocumentOpened" object:screenDocument];
            }else {
                [screenDocument openWithCompletionHandler:^(BOOL success) {
                    if(success){
                        [TestFlight passCheckpoint:@"ScreenDocument Opened"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScreenDocumentOpened" object:screenDocument];
                    }else{
                        [TestFlight passCheckpoint:@"ScreenDocument Failed to Open"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScreenDocumentOpened" object:nil];
                    }
                }];
            }
        }
    }];
}

+ (void)deleteScreenDocumentWithFileName:(NSString *)filename CompletionHandler:(void (^)(BOOL success))completionHandler;
{
    NSURL *fileUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    fileUrl = [fileUrl URLByAppendingPathComponent:filename];
    
    [[NSFileManager defaultManager] removeItemAtPath:[fileUrl path] error:NULL]; 
}


// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        

    }
    
    return self;
}

- (id)initWithFileURL:(NSURL *)url{
    self = [super initWithFileURL:url];
    
    if (self){
            
    }
    
    return self;
}

- (void)handleError:(NSError *)error userInteractionPermitted:(BOOL)userInteractionPermitted
{
    NSLog(@"ScreenDocument has error: %@",error);
    [super handleError:error userInteractionPermitted:userInteractionPermitted];
}

@end
