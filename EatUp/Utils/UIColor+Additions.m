//
//  UIColor+Additions.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithR:(int)r g:(int)g b:(int)b
{
    return [UIColor colorWithRed:(float)r/255. green:(float)g/255. blue:(float)b/255. alpha:1.];
}

@end
