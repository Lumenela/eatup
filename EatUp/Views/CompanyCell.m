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


@interface CompanyCell()<UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end

@implementation CompanyCell

- (void)setCompany:(Company *)company
{
    _company = company;
    [self.collectionView reloadData];
    self.descriptionLabel.text = @"Лидо, 14:00, 6 человек";
}


- (IBAction)join:(id)sender
{
    [self.delegate joinCompany:self.company];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section 
{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PersonCellId";
    
    PersonInCompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:@"ava"];
    image = [image thumbnail];
    cell.imageView.image = image;
    
    return cell;
}

@end
