//
//  TimePlaceHeaderView.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePlaceDelegate;
@interface TimePlaceHeaderView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, weak) id<TimePlaceDelegate> delegate;

+ (instancetype)header;

@end


@protocol TimePlaceDelegate<NSObject>

- (void)changeDate;
- (void)changePlace;

@end