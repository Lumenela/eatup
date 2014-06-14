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

typedef NS_ENUM(NSInteger, SectionIndex) {
    SectionIndexTime = 0,
    SectionIndexPlace = 1
};

@interface LunchConfigViewController ()<UITableViewDelegate, UITableViewDataSource, TimeDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, copy) PickTimeCompletionHandler onPickTime;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SectionIndexTime:
            return 1;
        case SectionIndexPlace:
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
        }
        /*case SectionIndexPlace: {
            static NSString *PlaceCellId = @"PlaceCellId";
            PlaceCell *cell = (PlaceCell *)[tableView dequeueReusableCellWithIdentifier:PlaceCellId];
            if (!cell) {
                cell = [[PlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellId];
            }
        }*/
        default: {
            static NSString *CellId = @"CellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
            }
            return cell;
        }
            
    }
}


- (void)pickTimeWithCompletionHandler:(PickTimeCompletionHandler)time
{
    
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
