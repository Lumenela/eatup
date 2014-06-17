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
#import "TimePlaceHeaderView.h"

@interface MeetingView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet TimePlaceHeaderView *timePlaceView;
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
    self.collectionView.delegate = self;
}


- (void)setCompany:(Company *)company
{
    _company = company;
    self.timePlaceView.place = company.place.name;
    self.timePlaceView.date = company.time;
    self.people = company.person.allObjects;
    [self.collectionView reloadData];
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    float widthForAllPeople = 55 * self.people.count;
    if (widthForAllPeople < collectionView.frame.size.width) {
        float marginSide = (collectionView.frame.size.width - widthForAllPeople)/2;
        UIEdgeInsets insets = UIEdgeInsetsMake(0, marginSide, 0, marginSide);
        return insets;
    }
    return UIEdgeInsetsZero;
}

@end
