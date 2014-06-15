//
//  EatUpService.m
//  EatUp
//
//  Created by Sveta Dedunovich on 6/14/14.
//  Copyright (c) 2014 Lumenela. All rights reserved.
//

#import "EatUpService.h"
#import "ParseUtil.h"
#import "Place.h"
#import "LAppDelegate.h"


NSString * const ProfileInfoURL = @"http://10.168.0.255/Cmd.EatUp/Employees/getprofileinfo";
NSString * const PlacesUrl = @"http://10.168.0.255/Cmd.EatUp/Employees/getplaces";
NSString * const SendTimeAndPlaceUrl = @"http://10.168.0.255/Cmd.EatUp/Employees/ChangePlaceAndTime";

NSString * const TimeKey = @"time";
NSString * const PlaceKey = @"placeName";
NSString * const IdKey = @"profileid";


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
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self GET:ProfileInfoURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf updateProfileWithJson:responseObject];
        [weakSelf placesWithCompletionHandler:^(id data, NSError *error) {
            onComplete(nil, nil);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        onComplete(nil, error);
    }];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", nil];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
}


- (void)updateProfileWithJson:(NSDictionary *)json
{
    [ParseUtil meFromJson:json];
}


- (void)placesWithCompletionHandler:(EUCompletionHandler)onComplete
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self GET:PlacesUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf updatePlacesWithJson:responseObject];
        onComplete(nil, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        onComplete(nil, error);
    }];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", nil];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation start];
}

- (void)updatePlacesWithJson:(NSArray *)json
{
    for (NSDictionary *placeJson in json) {
        [ParseUtil placeFromJson:placeJson];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)companiesWithCompletionHandler:(EUCompletionHandler)onComplete
{
    
}


- (void)sendTimeAndPlaceWithCompletionHandler:(EUCompletionHandler)onComplete
{
    Me *me = ApplicationDelegate.me;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DateFormat;
    NSString *timeString = [formatter stringFromDate:me.time];
    
    NSString *placeName = me.place.name;
    placeName = placeName ? placeName : @"";
    NSDictionary *params = @{IdKey : @(541), PlaceKey : placeName, TimeKey : timeString};
    
    AFHTTPRequestOperation *operation = [self GET:SendTimeAndPlaceUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        onComplete(nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onComplete(nil, error);
    }];

    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", nil];
    [operation start];
}

@end
