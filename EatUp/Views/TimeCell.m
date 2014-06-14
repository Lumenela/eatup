//
//  TimeCell.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "TimeCell.h"

@interface TimeCell()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end


@implementation TimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


- (void)awakeFromNib
{
}


- (void)setTime:(NSDate *)time
{
    _time = time;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *string = [formatter stringFromDate:time];
    self.timeLabel.text = string;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
