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
#import "Place.h"
#import "PlacePicker.h"
#import "LAppDelegate.h"
#import "TableHeaderView.h"
#import "EatUpService.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface InviteViewController ()<UITableViewDataSource, UITableViewDelegate, PersonCellDelegate, TimePlaceDelegate, PickerDelegate, PlacePickerDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PopUpWithBar *timePicker;
@property (nonatomic, strong) TimePlaceHeaderView *timePlaceHeader;
@property (nonatomic, strong) PlacePicker *placePicker;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

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
    self.timePicker.date = ApplicationDelegate.me.time;
    [self.timePicker setFrame:CGRectMake(0, self.view.frame.size.height, self.timePicker.frame.size.width, self.timePicker.frame.size.height)];
    [self.timePicker setDisablesScreen:YES];
    [self.view addSubview:self.timePicker];
    
    NSArray *placePickerObjects = [[NSBundle mainBundle] loadNibNamed:@"PlacePicker" owner:nil options:nil];
    self.placePicker = [placePickerObjects objectAtIndex:0];
    self.placePicker.delegate = self;
    self.placePicker.place = ApplicationDelegate.me.place;
    [self.placePicker setFrame:CGRectMake(0, self.view.frame.size.height, self.placePicker.frame.size.width, self.placePicker.frame.size.height)];
    [self.placePicker setDisablesScreen:YES];
    [self.view addSubview:self.placePicker];
    
    [self createTimePlaceView];
    [self.view addSubview:self.timePlaceHeader];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MBProgressHUD showHUDAddedTo:ApplicationDelegate.window animated:YES];
    __weak typeof(self) weakSelf = self;
    [[EatUpService sharedInstance] peopleToInviteWithCompletionHandler:^(id data, NSError *error) {
        weakSelf.fetchedResultsController = [Person MR_fetchAllGroupedBy:@"isSelected" withPredicate:[NSPredicate predicateWithFormat:@"isPref = YES"] sortedBy:@"index" ascending:YES];
        weakSelf.fetchedResultsController.delegate = self;
        [weakSelf.tableView reloadData];

        [MBProgressHUD hideHUDForView:ApplicationDelegate.window animated:YES];
    }];
}


- (void)invitePerson:(Person *)person
{
    person.isSelected = @(!person.isSelected.boolValue);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSInteger numberOfObject = [sectionInfo numberOfObjects];
    return numberOfObject;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.fetchedResultsController.sectionIndexTitles objectAtIndex:section];
    if ([title isEqualToString:@"0"]) {
        return @"Все коллеги";
    } else if ([title isEqualToString:@"1"]) {
        return @"Приглашенные";
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderStyle style = 2;
    NSString *title = [self.fetchedResultsController.sectionIndexTitles objectAtIndex:section];
    if ([title isEqualToString:@"0"]) {
        style = TableHeaderStyleAllPeople;
    } else if ([title isEqualToString:@"1"]) {
        style = TableHeaderStyleinvited;
    }
    TableHeaderView *header = [TableHeaderView headerForStyle:style];
    return header;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_HEADER_HEIGHT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PersonCellId = @"PersonCell";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonCellId];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonCellId];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller 
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert: {
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            PersonCell *cell = (PersonCell *)[tableView cellForRowAtIndexPath:indexPath];
            [self configureCell:cell atIndexPath:indexPath];
            break;
        }
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PersonCell class]]) {
        PersonCell *personCell = (PersonCell *)cell;
        Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
        personCell.person = person;
        personCell.delegate = self;
        personCell.canInvitePeople = [self canInviteSomeone];
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type 
{    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller 
{
    [self.tableView endUpdates];
}


- (BOOL)canInviteSomeone
{
    return ApplicationDelegate.me.place && ApplicationDelegate.me.time;
}


- (UIView *)createTimePlaceView
{
    if (_timePlaceHeader) {
        return _timePlaceHeader;
    }
    TimePlaceHeaderView *view = [TimePlaceHeaderView header];
    view.date = [NSDate date];
    view.place = @"Лидо";
    view.delegate = self;
    CGRect frame = view.frame;
    frame.origin.y = 64;
    view.frame = frame;
    
    Me *me = ApplicationDelegate.me;
    view.date = me.time;
    view.place = me.place.name;
    
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
    ApplicationDelegate.me.time = date;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)changeDate
{
    [self.timePicker show];
}


- (void)changePlace
{
    [self.placePicker show];
}


- (void)didPickPlace:(Place *)place
{
    self.timePlaceHeader.place = place.name;
    ApplicationDelegate.me.place = place;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
