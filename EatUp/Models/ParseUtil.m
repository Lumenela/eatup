//
//  ParseUtil.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/15/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "ParseUtil.h"
#import "Me.h"
#import "Company.h"
#import "Place.h"
#import "Person.h"


NSString * const DateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

NSString * const MeKeyName = @"FullName";
NSString * const MeKeyTime = @"ExactTime";
NSString * const MeKeyStartTime = @"StartPreferredTime";
NSString * const MeKeyEndTime = @"FinishPreferredTime";
NSString * const MeKeyMeeting = @"CurrentMeeting";
NSString * const MeKeyImagePath = @"ImagePath";

NSString * const CompanyKeyId = @"Id";
NSString * const CompanyKeyDate = @"Date";
NSString * const CompanyKeyPeople = @"Employees";

NSString * const PlaceKeyName = @"PlaceName";

NSString * const PersonKeyId = @"Id";
NSString * const PersonKeyImagePath = @"ImagePath";
NSString * const PersonKeyName = @"FullName";


/*
 Achievements = "<null>";

 Invitations = "<null>";
 LastName = "\U0414\U0435\U0434\U0443\U043d\U043e\U0432\U0438\U0447";
 StartPreferredTime = "2014-06-15T12:30:00";

 */

@implementation ParseUtil

+ (Me *)meFromJson:(NSDictionary *)json
{
    Me *me;
    NSArray *mes = [Me MR_findAll];
    if (mes.count > 0) {
        me = [mes objectAtIndex:0];
    } else {
        me = [Me MR_createEntity];
    }
    me.name = [json objectForKey:MeKeyName];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DateFormat;
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    
    NSString *time = [json objectForKey:MeKeyTime];
    me.time = [formatter dateFromString:time];
    
    NSString *startDate = [json objectForKey:MeKeyStartTime];
    me.startTime = [formatter dateFromString:startDate];
    
    NSString *endDate = [json objectForKey:MeKeyEndTime];
    me.endTime = [formatter dateFromString:endDate];
    
    NSDictionary *meetingJson = [json objectForKey:MeKeyMeeting];
    
    if (meetingJson && ![meetingJson isEqual:[NSNull null]] && meetingJson.count > 0) {
        me.meeting = [ParseUtil companyFromJson:meetingJson];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    return me;
}


+ (Company *)companyFromJson:(NSDictionary *)json
{
    Company *company;
    NSNumber *companyId = [json objectForKey:CompanyKeyId];
    
    NSArray *companies = [Company MR_findByAttribute:@"companyId" withValue:companyId];
    if (companies.count > 0) {
        company = [companies objectAtIndex:0];
    } else {
        company = [Company MR_createEntity];
    }
    company.companyId = companyId;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DateFormat;
    NSString *date = [json objectForKey:CompanyKeyDate];
    company.time = [formatter dateFromString:date];
    // people
   
    NSArray *people = [json objectForKey:CompanyKeyPeople];
    for (NSDictionary *personJson in people) {
        Person *person = [ParseUtil personFromJson:personJson];
        if (![company.person containsObject:person]) {
            [company addPersonObject:person];
        }
    }
    
    company.place = [ParseUtil placeFromJson:json];
    
    [[NSManagedObjectContext MR_context] MR_saveOnlySelfAndWait];
    return company;
}


+ (Person *)personFromJson:(NSDictionary *)json
{
    NSNumber *personId = [json objectForKey:PersonKeyId];
    Person *person;
    
    NSArray *persons = [Person MR_findByAttribute:@"userId" withValue:personId];
    if (persons.count > 0) {
        person = [persons objectAtIndex:0];
    } else {
        person = [Person MR_createEntity];
    }
    
    person.userId = personId;
    person.name = [json objectForKey:PersonKeyName];
    person.imageURLString = [json objectForKey:PersonKeyImagePath];
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    return person;
}


+ (Place *)placeFromJson:(NSDictionary *)json
{
    NSString *name = [json objectForKey:PlaceKeyName];
    Place *place;
    NSArray *places = [Place MR_findByAttribute:@"name" withValue:name];
    if (places.count > 0) {
        place = [places objectAtIndex:0];
    } else {
        place = [Place MR_createEntity];
    }
    place.name = name;
    [[NSManagedObjectContext MR_context] MR_saveOnlySelfAndWait];
    return place;
}


@end
