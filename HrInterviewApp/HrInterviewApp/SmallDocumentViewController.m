//
//  SmallDocumentViewController.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmallDocumentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SmallDocumentViewController ()

@end

@implementation SmallDocumentViewController

@synthesize documentImageView = _documentImageView;
@synthesize documentLabel = _documentLabel;
@synthesize progressView = _progressView;
@synthesize delegate = _delegate;
@synthesize documentFileUrl = _documentFileUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.documentImageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.documentImageView.layer setShadowOpacity:0.4];
    [self.documentImageView.layer setShadowRadius:5.0];
    [self.documentImageView.layer setShadowOffset:CGSizeMake(0, 7.0)];
    
    self.progressView.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)handleTap
{
    NSLog(@"Tapped on document with label: %@",self.documentLabel.text);
    [self.delegate documentWasTapped:self.documentFileUrl Sender:self];
}

@end
