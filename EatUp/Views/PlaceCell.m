//
//  PlaceCell.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PlaceCell.h"

@interface PlaceCell()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) UIButton *checkbox;

@end


@implementation PlaceCell

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

- (void)setupCheckbox
{
    UIImage *checked = [UIImage imageNamed:@"checked"];
    [self.checkbox setImage:checked forState:UIControlStateSelected];
    [self.checkbox setImage:checked forState:UIControlStateHighlighted];
    
    
    UIImage *unchecked = [UIImage imageNamed:@"unchecked"];
    [self.checkbox setImage:unchecked forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlace:(Place *)place
{
    _place = place;
    self.nameLabel.text = place.name;
}

@end
