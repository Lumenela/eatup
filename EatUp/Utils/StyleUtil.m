//
//  StyleUtil.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "StyleUtil.h"
#import "UIColor+Additions.h"

@implementation StyleUtil

+ (UIColor *)loginBackgroundColor
{
    return [UIColor colorWithR:123 g:192 b:197];
}

+ (UIColor *)yellowColor
{
    return [UIColor colorWithR:248 g:194 b:81];
}

+ (UIColor *)darkColor
{
    return [UIColor colorWithR:87 g:65 b:77];
}

+ (UIFont *)headlineFont
{
    return [UIFont fontWithName:@"AvenirNext-Medium" size:20.0];
}

+ (UIFont *)barButtonFont
{
    return [UIFont fontWithName:@"AvenirNext-Medium" size:15.0];
}

+ (UIFont *)bigTitleFont
{
    return [UIFont fontWithName:@"AvenirNext-Regular" size:30.0];
}

@end
