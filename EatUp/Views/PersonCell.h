//
//  PersonCell.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"


@protocol PersonCellDelegate;
@interface PersonCell : UITableViewCell

@property (nonatomic, strong) Person *person;
@property (nonatomic, weak) id<PersonCellDelegate> delegate;
@property (nonatomic, assign) BOOL canInvitePeople;

@end


@protocol PersonCellDelegate

- (void)invitePerson:(Person *)person;

@end
