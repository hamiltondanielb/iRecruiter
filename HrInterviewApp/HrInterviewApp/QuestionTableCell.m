//
//  QuestionTableCell.m
//  HrInterviewApp
//
//  Created by Ryan Billingsley on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionTableCell.h"
#import "Common.h"

@implementation QuestionTableCell

@synthesize ratingView = _ratingView;
@synthesize questionLabel = _questionLabel;
@synthesize drawSeperator = _drawSeperator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    GradientCellBackgroundView *gradient = [[GradientCellBackgroundView alloc] initWithFrame:self.backgroundView.bounds DrawSeperator:self.drawSeperator];
    //[self.backgroundView addSubview:gradient];
    //[self.backgroundView sendSubviewToBack:gradient];
    
    self.backgroundView = gradient;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
