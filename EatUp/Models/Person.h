//
//  Person.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * imageURLString;
@property (nonatomic, retain) NSSet *company;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addCompanyObject:(NSManagedObject *)value;
- (void)removeCompanyObject:(NSManagedObject *)value;
- (void)addCompany:(NSSet *)values;
- (void)removeCompany:(NSSet *)values;

@end
