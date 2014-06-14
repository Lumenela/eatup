//
//  Place.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *company;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addCompanyObject:(Company *)value;
- (void)removeCompanyObject:(Company *)value;
- (void)addCompany:(NSSet *)values;
- (void)removeCompany:(NSSet *)values;

@end
