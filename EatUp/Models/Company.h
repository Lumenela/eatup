//
//  Company.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSManagedObject *place;
@property (nonatomic, retain) NSSet *person;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet *)values;
- (void)removePerson:(NSSet *)values;

@end
