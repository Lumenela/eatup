//
//  EatUpService.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "EatUpService.h"
#import "Me.h"


NSString * const ProfileInfoURL = @"http://10.168.0.255/Cmd.EatUp/Employees/getprofileinfo";


@implementation EatUpService

+ (instancetype)sharedInstance
{
    static EatUpService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [EatUpService new];
    });
    return service;
}


- (void)loginWithCompletionHandler:(EUCompletionHandler)onComplete
{
    onComplete(@"token", nil);
}


- (void)profileInfoWithCompletionHandler:(EUCompletionHandler)onComplete
{
    NSDictionary *params = @{@"id": @(541)};
    AFHTTPRequestOperation *operation = [self GET:ProfileInfoURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", nil];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
}

- (void)companiesWithCompletionHandler:(EUCompletionHandler)onComplete
{
    
}

@end
