//
//  TableHeaderView.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "TableHeaderView.h"

@interface TableHeaderView()

@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end


@implementation TableHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (TableHeaderView *)headerForStyle:(TableHeaderStyle)style
{
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil];
    TableHeaderView *view = [objects objectAtIndex:0];
    switch (style) {
        case TableHeaderStyleTime: {
            UIImage *image = [UIImage imageNamed:@"clock"];
            view.icon.image = image;
            view.label.text = @"ВРЕМЯ";
            break;
        }
        case TableHeaderStylePlace: {
            UIImage *image = [UIImage imageNamed:@"place"];
            view.icon.image = image;
            view.label.text = @"МЕСТО";
            break;
        }
        case TableHeaderStyleAllPeople: {
            view.icon.image = nil;
            view.label.text = @"ВСЕ КОЛЛЕГИ";
            break;
        }
        case TableHeaderStyleinvited: {
            view.icon.image = nil;
            view.label.text = @"ПРИГЛАШЕННЫЕ";
        }
    }
    return view;
}

@end
