//
//  MeetingView.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "MeetingView.h"
#import "Place.h"
#import "PersonInCompanyCell.h"
#import "Person.h"

@interface MeetingView()<UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSArray *people;

@end


@implementation MeetingView

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
    self.collectionView.dataSource = self;
    self.descriptionLabel.text = @"";
}


- (void)setCompany:(Company *)company
{
    _company = company;
    [self.collectionView reloadData];
    
    NSString *place = company.place.name;
    
    NSDate *date = company.time;    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@, %@", place, dateString];
    self.people = company.person.allObjects;

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section 
{
    return self.people.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PersonCellId";
    
    Person *person = [self.people objectAtIndex:indexPath.row];
    
    PersonInCompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString *imageURL = person.imageURLString;
    [cell setImageUrl:imageURL];
    
    return cell;
}

@end
