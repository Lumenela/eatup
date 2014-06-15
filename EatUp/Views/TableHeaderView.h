//
//  TableHeaderView.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TableHeaderStyle) {
    TableHeaderStyleTime = 0,
    TableHeaderStylePlace = 1,
    TableHeaderStyleAllPeople = 2,
    TableHeaderStyleinvited = 3
};

@interface TableHeaderView : UIView

+ (TableHeaderView *)headerForStyle:(TableHeaderStyle)style;

@end
