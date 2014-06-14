//
//  PersonCell.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PersonCell.h"
#import "UIImage+Additions.h"
#import "StyleUtil.h"

@interface PersonCell()

@property (nonatomic, weak) IBOutlet UIImageView *photoView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *inviteButton;

@end


@implementation PersonCell

- (void)awakeFromNib
{
    self.photoView.layer.cornerRadius = self.photoView.frame.size.width / 2;
    self.photoView.clipsToBounds = YES;
    self.photoView.layer.borderWidth = 2.0f;
    self.photoView.layer.borderColor = [StyleUtil loginBackgroundColor].CGColor;
    self.photoView.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCanInvite) name:CanInvitePeopleNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCanNotInvite) name:CannotInvitePeopleNotificationName object:nil];
}


- (void)handleCanInvite
{
    self.canInvitePeople = YES;
}


- (void)handleCanNotInvite
{
    self.canInvitePeople = NO;
}


- (void)setPerson:(Person *)person
{
    _person = person;
    UIImage *image = [UIImage imageNamed:@"ava"];
    image = [image thumbnail];
    self.photoView.image = image;
    self.nameLabel.text = @"Svetlana Dedunovich Svetlana Dedunovich";
}


- (IBAction)invite:(id)sender
{
    [self.delegate invitePerson:self.person];
}


- (void)setCanInvitePeople:(BOOL)canInvitePeople
{
    _canInvitePeople = canInvitePeople;
    self.inviteButton.enabled = _canInvitePeople;
}


@end
