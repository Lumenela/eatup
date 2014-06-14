//
//  PlacePicker.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PopUpView.h"

@protocol PlacePickerDelegate;
@interface PlacePicker : PopUpView

@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, weak) id<PlacePickerDelegate> delegate;

@end


@protocol PlacePickerDelegate<NSObject>

- (void)didPickPlace:(NSString *)place;

@end
