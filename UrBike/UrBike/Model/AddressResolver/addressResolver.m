//
//  adressResolver.m
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import "addressResolver.h"
#import "addressObject.h"

@implementation addressResolver

-(void)getAddress:(NSString *)baseAdress
{
    self.addressArray = [[NSMutableSet alloc] init];
    if (self.baseRequest == nil)
    {
        self.baseRequest = [[NSMutableString alloc] init];
        [self.baseRequest appendString:@"http://maps.googleapis.com/maps/api/geocode/json?address="];
    }
    NSMutableString *urlRequest = [[NSMutableString alloc] init];
    [urlRequest appendString:self.baseRequest];
    [urlRequest appendString:baseAdress];
    [urlRequest appendString:@"&sensor=true"];
    NSURL *url = [[NSURL alloc] initWithString:[urlRequest stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError* error;
         NSLog(@"REQUEST OK");
         self.results = [NSJSONSerialization
                             JSONObjectWithData:responseObject
                             options:kNilOptions
                             error:&error];
         [self parseData];
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", [error localizedDescription]);
         _addressArray = nil;
     }];
    [operation start];
}

- (void)addObjectToArray:(NSNumber *)latitude curLongitude:(NSNumber *)longitude address:(NSString *)address city:(NSString *)city
{
//    NSLog(@"%@, %@, %@, %@", address, longitude, latitude, city);
    addressObject *addObject = [[addressObject alloc] init];
    [addObject setLat:latitude];
    [addObject setLon:longitude];
    [addObject setCity:city];
    [addObject setAddress:address];
    [_addressArray addObject:addObject];
}

-(void)parseData
{
    NSMutableString *concatAddress = [[NSMutableString alloc] init];
    NSNumber *lat = [[NSNumber alloc] init];
    NSNumber *lon = [[NSNumber alloc] init];
    NSMutableString *city = [[NSMutableString alloc] init];
    
    _results = _results[@"results"];
    for (id key in _results)
    {
        [city setString:@""];
        [concatAddress setString:@""];
        [concatAddress appendString:key[@"formatted_address"]];
        lat = key[@"geometry"][@"location"][@"lat"];
        lon = key[@"geometry"][@"location"][@"lng"];
        [city appendString:@"lyon"];
        [self addObjectToArray:lat curLongitude:lon address:concatAddress city:city];
    }
    [self testAddress];
}

-(void)testAddress
{
    NSLog(@"Resultats: %ld", [_addressArray count]);
//    for (addressObject *key in _addressArray)
//    {
//        NSLog(@"%@, %@, %@, %@", key.address, key.lon, key.lat, key.city);
//    }
}

@end
