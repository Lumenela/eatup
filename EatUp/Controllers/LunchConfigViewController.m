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


typedef NS_ENUM(NSInteger, SectionIndex) {
    SectionIndexTime = 0,
    SectionIndexPlace = 1,
    SectionIndexFind = 2
};

#define SECTION_COUNT 3

@interface LunchConfigViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *places;

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
    self.places = @[@"Rest room", @"Лидо", @"Налибоки", @"Колесо"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            // load last time
            cell.time = [NSDate date];
            return cell;
        }
        case SectionIndexPlace: {
            static NSString *PlaceCellId = @"PlaceCellId";
            PlaceCell *cell = (PlaceCell *)[tableView dequeueReusableCellWithIdentifier:PlaceCellId];
            if (!cell) {
                cell = [[PlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellId];
            }
            cell.place = [self.places objectAtIndex:indexPath.row];
            return cell;
        }   
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    switch (indexPath.section) {
        case SectionIndexTime: {
        
        }
        case SectionIndexPlace: {
            
        }
        case SectionIndexFind: {
            
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
