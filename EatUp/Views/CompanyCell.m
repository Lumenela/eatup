//
//  GroupCell.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "CompanyCell.h"
#import "PersonInCompanyCell.h"
#import "UIImage+Additions.h"
#import "Place.h"
#import "Person.h"


@interface CompanyCell()<UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSArray *people;

@end

@implementation CompanyCell

- (void)setCompany:(Company *)company
{
    _company = company;
    [self.collectionView reloadData];
    
    NSString *place = company.place.name;
    
    NSDate *date = company.time;    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSInteger personCount = company.person.count;
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@, %@, %d человек", place, dateString, personCount];
    self.people = company.person.allObjects;
}


- (IBAction)join:(id)sender
{
    [self.delegate joinCompany:self.company];
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
