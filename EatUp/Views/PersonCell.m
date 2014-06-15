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
#import "UIImage+Additions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>


@interface PersonCell()

@property (nonatomic, weak) IBOutlet UIImageView *photoView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *inviteButton;

@end


@implementation PersonCell

- (void)awakeFromNib
{
    [super awakeFromNib];
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
    
    self.nameLabel.text = person.name;
    
    NSURL *imageURL = [NSURL URLWithString:person.imageURLString];
    if (imageURL) {
        __weak typeof(self) weakSelf = self;
        //        UIImage *placeholder = [UIImage imageNamed:@"gift"];
        [self.photoView setImageWithURL:imageURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            image = [image thumbnail];
            weakSelf.photoView.image = image;
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    if (self.person.isSelected.boolValue) {
        [self.inviteButton setTitle:@"ОТМЕНИТЬ" forState:UIControlStateNormal];
        [self.inviteButton setBackgroundImage:[UIImage imageNamed:@"reject"] forState:UIControlStateNormal];
    } else {
        [self.inviteButton setTitle:@"ПРИГЛАСИТЬ" forState:UIControlStateNormal];
        [self.inviteButton setBackgroundImage:[UIImage imageNamed:@"invite"] forState:UIControlStateNormal];
    }
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
