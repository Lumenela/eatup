//
//  Company.h
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person, Place;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * companyId;
@property (nonatomic, retain) NSSet *person;
@property (nonatomic, retain) Place *place;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet *)values;
- (void)removePerson:(NSSet *)values;

@end
