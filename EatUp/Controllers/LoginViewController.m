//
//  LoginViewController.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "LoginViewController.h"
#import "LAppDelegate.h"
#import "EatUpService.h"
#import "StyleUtil.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *loginTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [StyleUtil yellowColor];
}


- (IBAction)login:(id)sender
{
    if ([self isDataValid]) {
        [MBProgressHUD showHUDAddedTo:ApplicationDelegate.window animated:YES];
        
        __weak typeof(self) weakSelf = self;
        [[EatUpService sharedInstance] loginWithCompletionHandler:^(id data, NSError *error) {
            [MBProgressHUD hideHUDForView:ApplicationDelegate.window animated:YES];
            if (!error) {
                [weakSelf handleSuccessfullLogin:data];
            } else {
                [weakSelf handleFailedLoginWithData:data error:error];
            }
        }];
    } else {
        [self showInvalidDataHint];
    }
}


- (BOOL)isDataValid
{
    return YES;
}


- (void)handleSuccessfullLogin:(id)data
{
    //save token
    [ApplicationDelegate showMainAppView];
}


- (void)handleFailedLoginWithData:(id)data error:(NSError *)error
{
    
}


- (void)showInvalidDataHint
{
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    float keyboardOriginY = self.view.frame.size.height - KEYBOARD_HEIGHT;
    float margin = 5;
    float newTextFieldOriginY = keyboardOriginY - self.loginButton.frame.size.height - margin;
    float deltaOriginY = self.loginButton.frame.origin.y - newTextFieldOriginY;
    if (deltaOriginY <= 0) {
        return;
    }
    float oldOffset = self.scrollView.contentOffset.y;
    float newOffset = oldOffset + deltaOriginY;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(0, newOffset);
    } completion:nil];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weakSelf.scrollView.contentOffset = CGPointZero;
    } completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginTextField) {
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
        return NO;
    }
    [textField resignFirstResponder];
    [self login:nil];
    return NO;
}

@end
