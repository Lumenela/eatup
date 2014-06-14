//
//  LAppDelegate.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Me.h"

#define ApplicationDelegate ((LAppDelegate *)[UIApplication sharedApplication].delegate)

@interface LAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showMainAppView;
- (Me *)me;

@end
