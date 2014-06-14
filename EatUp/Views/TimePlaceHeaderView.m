//
//  TimePlaceHeaderView.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "TimePlaceHeaderView.h"

@interface TimePlaceHeaderView()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeLabel;

@end

@implementation TimePlaceHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)changeDate:(id)sender
{
    [self.delegate changeDate];
}


- (IBAction)changePlace:(id)sender
{
    [self.delegate changePlace];
}


- (void)setDate:(NSDate *)date
{
    _date = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *string = [formatter stringFromDate:date];
    self.timeLabel.text = string;
}


- (void)setPlace:(NSString *)place
{
    _place = place;
    self.placeLabel.text = place;
}


+ (instancetype)header
{
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TimePlaceHeader" owner:nil options:nil];
    TimePlaceHeaderView *view = [objects objectAtIndex:0];
    return view;
}

@end
