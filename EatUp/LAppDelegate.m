//
//  LAppDelegate.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "LAppDelegate.h"
#import "LunchConfigViewController.h"
#import "StyleUtil.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation LAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"EatUpModel"];
    [self setupAppearance];
    return YES;
}

- (void)showMainAppView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LunchConfigViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:AppWrapperControllerId];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}

- (void)setupAppearance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary *textAttributes = @{NSFontAttributeName :[StyleUtil headlineFont],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    
    UIImage *navBackgroundTile = [UIImage imageNamed:@"nav-bg-tile"];
    [[UINavigationBar appearance] setBackgroundImage:[navBackgroundTile resizableImageWithCapInsets:UIEdgeInsetsZero] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName :[StyleUtil barButtonFont],
                                                           NSForegroundColorAttributeName : [StyleUtil yellowColor]} forState:UIControlStateNormal];
}

- (Me *)me
{
    NSArray *mes = [Me MR_findAll];
    if (mes.count > 0) {
        Me *me = [mes objectAtIndex:0];
        return me;
    }
    return nil;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
