//
//  EatUpService.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef void (^EUCompletionHandler)(id data, NSError *error);

@interface EatUpService : AFHTTPRequestOperationManager

+ (EatUpService *)sharedInstance;

- (void)loginWithCompletionHandler:(EUCompletionHandler)onComplete;
- (void)profileInfoWithCompletionHandler:(EUCompletionHandler)onComplete;
- (void)sendTimeAndPlaceWithCompletionHandler:(EUCompletionHandler)onComplete;
- (void)companiesWithCompletionHandler:(EUCompletionHandler)onComplete;
- (void)peopleToInviteWithCompletionHandler:(EUCompletionHandler)onComplete;
- (void)joinCompany:(NSNumber *)companyId withCompletionHandler:(EUCompletionHandler)onComplete;
- (void)inviteWithCompletionHandler:(EUCompletionHandler)onComplete;

@end
