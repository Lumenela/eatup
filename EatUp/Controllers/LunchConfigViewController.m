//
//  LunchConfigViewController.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "LunchConfigViewController.h"
#import "PlaceCell.h"
#import "TimeCell.h"
#import "TableHeaderView.h"
#import "StyleUtil.h"
#import "PopUpWithBar.h"
#import "EatUpService.h"
#import "LAppDelegate.h"
#import "Me.h"
#import "Place.h"
#import <MBProgressHUD/MBProgressHUD.h>


typedef NS_ENUM(NSInteger, SectionIndex) {
    SectionIndexTime = 0,
    SectionIndexPlace = 1,
    SectionIndexFind = 2
};

#define SECTION_COUNT 3

@interface LunchConfigViewController ()<UITableViewDelegate, UITableViewDataSource, PickerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) Place *selectedPlace;

@property (nonatomic, strong) PopUpWithBar *pickerPopUp;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) TimeCell *timeCell;

@end

@implementation LunchConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"PopUpPicker" owner:nil options:nil];
    self.pickerPopUp = [objects objectAtIndex:0];
    self.pickerPopUp.delegate = self;
    [self.pickerPopUp setFrame:CGRectMake(0, self.view.frame.size.height, self.pickerPopUp.frame.size.width, self.pickerPopUp.frame.size.height)];
    [self.pickerPopUp setDisablesScreen:YES];
    [self.view addSubview:self.pickerPopUp];
    
    [self updateTimeAndPlace];
    
    [MBProgressHUD showHUDAddedTo:ApplicationDelegate.window animated:YES];
    __weak typeof(self) weakSelf = self;
    [[EatUpService sharedInstance] profileInfoWithCompletionHandler:^(id data, NSError *error) {
        [MBProgressHUD hideHUDForView:ApplicationDelegate.window animated:YES];
        if (!error) {
            [weakSelf updateTimeAndPlace];
        }
    }];
}

- (void)updateTimeAndPlace
{
    Me *me = ApplicationDelegate.me;
    self.selectedDate = me.time;
    self.selectedPlace = me.place ? me.place : nil;
    
    self.places = [Place MR_findAll];
    [self.tableView reloadData];
}

- (void)didPickDate:(NSDate *)date
{
    self.selectedDate = date;
    self.timeCell.time = date;
    
    ApplicationDelegate.me.time = date;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SectionIndexTime:
            return 1;
        case SectionIndexPlace:
            return self.places.count;
        case SectionIndexFind:
            return 0;
    }
    return 0;
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SectionIndexTime:
            return 60;
        case SectionIndexPlace:
            return 44;
        case SectionIndexFind:
            return 0;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SectionIndexTime: {
            static NSString *TimeCellId = @"TimeCellId";
            TimeCell *cell = (TimeCell *)[tableView dequeueReusableCellWithIdentifier:TimeCellId];
            if (!cell) {
                cell = [[TimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TimeCellId];
            }
            cell.time = self.selectedDate;
            self.timeCell = cell;
            return cell;
        }
        case SectionIndexPlace: {
            static NSString *PlaceCellId = @"PlaceCellId";
            PlaceCell *cell = (PlaceCell *)[tableView dequeueReusableCellWithIdentifier:PlaceCellId];
            if (!cell) {
                cell = [[PlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellId];
            }
            Place *place = [self.places objectAtIndex:indexPath.row];
            cell.place = place.name;
            if ([place.name isEqualToString:self.selectedPlace.name]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }   
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    switch (indexPath.section) {
        case SectionIndexTime: {
            self.pickerPopUp.date = self.selectedDate;
            [self.pickerPopUp show];
            break;
        }
        case SectionIndexPlace: {
            Place *place = [self.places objectAtIndex:indexPath.row];
            self.selectedPlace = place;
            ApplicationDelegate.me.place = place;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [self.tableView reloadData];
           /* UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;*/
            break;
        }
        case SectionIndexFind: {
            break;
        }
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SectionIndexTime: {
            break;
        }
        case SectionIndexPlace: {
           /* self.selectedPlace = nil;
            ApplicationDelegate.me.place = nil;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;*/
            break;
        }
        case SectionIndexFind: {
            break;
        }
    }
}


- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == SectionIndexFind) {
        return 57;
    }
    return TABLE_HEADER_HEIGHT;
}



- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == SectionIndexFind) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 57)];
        button.backgroundColor = [StyleUtil yellowColor];
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [StyleUtil darkColor], 
                                     NSFontAttributeName : [StyleUtil bigTitleFont]};
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"Найти компанию" attributes:attributes];
        button.contentMode = UIViewContentModeCenter;
        [button setAttributedTitle:text forState:UIControlStateNormal];
        [button addTarget:self action:@selector(findCompany:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    
    TableHeaderStyle style = 0;
    switch (section) {
        case SectionIndexTime: {
            style = TableHeaderStyleTime;
            break;
        }
        case SectionIndexPlace: {
            style = TableHeaderStylePlace;
            break;
        }
    }
    TableHeaderView *header = [TableHeaderView headerForStyle:style];
    return header;
}


- (void)findCompany:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:ApplicationDelegate.window animated:YES];
    [[EatUpService sharedInstance] sendTimeAndPlaceWithCompletionHandler:^(id data, NSError *error) {
        if (!error) {
            [weakSelf performSegueWithIdentifier:FindCompanySegueId sender:self];
        }
        [MBProgressHUD hideHUDForView:ApplicationDelegate.window animated:YES];
    }];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
