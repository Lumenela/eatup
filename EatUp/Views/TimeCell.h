//
//  TimeCell.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickTimeCompletionHandler)(NSDate *time);


@protocol TimeDelegate;
@interface TimeCell : UITableViewCell

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, weak) id<TimeDelegate> delegate;

@end


@protocol TimeDelegate

- (void)pickTimeWithCompletionHandler:(PickTimeCompletionHandler)time;

@end
