//
//  TimeCell.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeDelegate;
@interface TimeCell : UITableViewCell

@property (nonatomic, strong) NSDate *time;

@end
