//
//  GroupCell.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@protocol CompanyCellDelegate;
@interface CompanyCell : UITableViewCell

@property (nonatomic, strong) Company *company;
@property (nonatomic, weak) id<CompanyCellDelegate> delegate;

@end


@protocol CompanyCellDelegate<NSObject>

- (void)joinCompany:(Company *)company;

@end