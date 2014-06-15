//
//  PersonInCompanyCell.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "PersonInCompanyCell.h"
#import "StyleUtil.h"
#import "UIImage+Additions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>


@interface PersonInCompanyCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end


@implementation PersonInCompanyCell

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
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 2.0f;
    self.imageView.layer.borderColor = [StyleUtil loginBackgroundColor].CGColor;
}

- (void)setImageUrl:(NSString *)urlString
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    if (imageURL) {
        __weak typeof(self) weakSelf = self;
        //        UIImage *placeholder = [UIImage imageNamed:@"gift"];
        [self.imageView setImageWithURL:imageURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            image = [image thumbnail];
            weakSelf.imageView.image = image;
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
}

@end
