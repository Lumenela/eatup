//
//  PlacePicker.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PlacePicker.h"

@interface PlacePicker()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *places;

@end

@implementation PlacePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.places = @[@"Rest room", @"Лидо", @"Налибоки", @"Колесо"];
}


- (IBAction)done:(id)sender
{
    NSInteger row = [self.picker selectedRowInComponent:0];
    NSString *place = [self.places objectAtIndex:row];
    [self.delegate didPickPlace:place];
    [self hide];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.places.count;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *place = [self.places objectAtIndex:row];
    return place;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *place = [self.places objectAtIndex:row];
    [self.delegate didPickPlace:place];
}


- (void)setPlace:(NSString *)place
{
    NSInteger indexOfPlace = [self.places indexOfObject:place];
    [self.picker selectRow:indexOfPlace inComponent:0 animated:YES];
}

@end
