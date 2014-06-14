//
//  PopUpWithBar.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PopUpView.h"


@protocol PickerDelegate;
@interface PopUpWithBar : PopUpView

@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) id<PickerDelegate> delegate;

@end


@protocol PickerDelegate<NSObject>

- (void)didPickDate:(NSDate *)date;

@end
