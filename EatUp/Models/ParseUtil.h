//
//  ParseUtil.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Me.h"
#import "Person.h"

@interface ParseUtil : NSObject

+ (Me *)meFromJson:(NSDictionary *)json;

+ (Place *)placeFromJson:(NSDictionary *)json;
+ (Company *)companyFromJson:(NSDictionary *)json;
+ (Person *)personFromJson:(NSDictionary *)json;

@end
