//
//  InviteViewController.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "InviteViewController.h"
#import "PersonCell.h"
#import "TimePlaceHeaderView.h"
#import "PopupWithBar.h"
#import "PlacePicker.h"


@interface InviteViewController ()<UITableViewDataSource, UITableViewDelegate, PersonCellDelegate, TimePlaceDelegate, PickerDelegate, PlacePickerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PopUpWithBar *timePicker;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) TimePlaceHeaderView *timePlaceHeader;
@property (nonatomic, strong) PlacePicker *placePicker;
@property (nonatomic, strong) NSString *place;

@end


@implementation InviteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"PopUpPicker" owner:nil options:nil];
    self.timePicker = [objects objectAtIndex:0];
    self.timePicker.delegate = self;
    [self.timePicker setFrame:CGRectMake(0, self.view.frame.size.height, self.timePicker.frame.size.width, self.timePicker.frame.size.height)];
    [self.timePicker setDisablesScreen:YES];
    [self.view addSubview:self.timePicker];
    
    NSArray *placePickerObjects = [[NSBundle mainBundle] loadNibNamed:@"PlacePicker" owner:nil options:nil];
    self.placePicker = [placePickerObjects objectAtIndex:0];
    self.placePicker.delegate = self;
    [self.placePicker setFrame:CGRectMake(0, self.view.frame.size.height, self.placePicker.frame.size.width, self.placePicker.frame.size.height)];
    [self.placePicker setDisablesScreen:YES];
    [self.view addSubview:self.placePicker];
}


- (void)invitePerson:(Person *)person
{
    //send request
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PersonCellId = @"PersonCell";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonCellId];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonCellId];
    }
    cell.person = nil;
    cell.canInvitePeople = [self canInviteSomeone];
    return cell;
}


- (BOOL)canInviteSomeone
{
    return self.place && self.time;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_timePlaceHeader) {
        return _timePlaceHeader;
    }
    TimePlaceHeaderView *view = [TimePlaceHeaderView header];
    view.date = [NSDate date];
    view.place = @"Лидо";
    view.delegate = self;
    self.timePlaceHeader = view;
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}


- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65;
}


- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
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

- (void)didPickDate:(NSDate *)date
{
    self.timePlaceHeader.date = date;
}


- (void)changeDate
{
    [self.timePicker show];
}


- (void)changePlace
{
    [self.placePicker show];
}


- (void)didPickPlace:(NSString *)place
{
    self.place = place;
    self.timePlaceHeader.place = place;
}

@end
