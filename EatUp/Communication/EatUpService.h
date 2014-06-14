//
//  EatUpService.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EUCompletionHandler)(id data, NSError *error);

@interface EatUpService : NSObject

+ (EatUpService *)sharedInstance;

- (void)loginWithCompletionHandler:(EUCompletionHandler)onComplete;

@end
