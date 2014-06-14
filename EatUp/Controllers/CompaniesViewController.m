//
//  GroupsViewController.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "CompaniesViewController.h"
#import "CompanyCell.h"
#import "StyleUtil.h"


typedef NS_ENUM(NSInteger, SectionIndex) {
    SectionIndexCompanies = 0,
    SectionIndexFind = 1
};

#define SECTION_COUNT 2


@interface CompaniesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end


@implementation CompaniesViewController

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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SectionIndexCompanies: {
            return 2;
        }
        case SectionIndexFind: {
            return 0;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SectionIndexCompanies: {
            static NSString *CompanyCellId = @"CompanyCellId";
            CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:CompanyCellId];
            if (!cell) {
                cell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CompanyCellId];
            }
            cell.company = nil;
            return cell;
        }
        case SectionIndexFind: {
            return 0;
        }
    }
    return nil;
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == SectionIndexFind) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, -20, 320, 57)];
        button.backgroundColor = [StyleUtil loginBackgroundColor];
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [StyleUtil darkColor], 
                                     NSFontAttributeName : [StyleUtil bigTitleFont]};
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"Пригласить коллег" attributes:attributes];
        button.contentMode = UIViewContentModeCenter;
        [button setAttributedTitle:text forState:UIControlStateNormal];
        [button addTarget:self action:@selector(findOthers) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    return nil;
}


- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == SectionIndexFind) {
        return 57;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)findOthers
{
    
}


@end