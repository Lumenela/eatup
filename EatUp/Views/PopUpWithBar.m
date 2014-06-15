//
//  PopUpWithBar.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PopUpWithBar.h"

@implementation PopUpWithBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    self.datePicker.date = date;
}

- (IBAction)dateChanged:(UIDatePicker *)datePicker
{
    [self.delegate didPickDate:datePicker.date];
}

- (IBAction)done:(id)sender
{
    [self.delegate didPickDate:self.datePicker.date];
    [self hide];
}

@end
