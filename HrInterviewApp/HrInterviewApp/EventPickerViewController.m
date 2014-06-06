//
//  EventPickerViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/29/12.
//
//

#import "EventPickerViewController.h"

@interface EventPickerViewController ()

@end

@implementation EventPickerViewController

@synthesize eventPicker = _eventPicker;

NSArray *eventsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupView];
}

- (void)setupView
{
    eventsArray = [NSArray arrayWithArray:[self loadEventsFromTemplate]];
}

- (NSArray *)loadEventsFromTemplate
{
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
    
    NSArray *eventsArray = [temp objectForKey:@"Events"];
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *eventDictionaryEntry in eventsArray) {
        [resultsArray addObject:[eventDictionaryEntry objectForKey:@"Name"]];
    }
    
    return resultsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //[self setupView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Picker View Datasource

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [eventsArray objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [eventsArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

#pragma mark - Pivker View Delegate

- (void)chooseEventFromPicker:(NSInteger)row
{
    NSLog(@"Event Picker chose %@",[eventsArray objectAtIndex:row]);
    
    [self.delegate eventPickerDidPickEvent:[eventsArray objectAtIndex:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self chooseEventFromPicker:row];
}

- (IBAction)tapGestureHandler:(id)sender {
    [self chooseEventFromPicker:[self.eventPicker selectedRowInComponent:0]];
}
@end
