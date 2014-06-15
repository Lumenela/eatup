//
//  Person.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * imageURLString;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * isPref;
@property (nonatomic, retain) NSNumber * isSelected;
@property (nonatomic, retain) NSSet *company;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addCompanyObject:(Company *)value;
- (void)removeCompanyObject:(Company *)value;
- (void)addCompany:(NSSet *)values;
- (void)removeCompany:(NSSet *)values;

@end
