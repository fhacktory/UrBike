//
//  adressResolver.m
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import "addressResolver.h"
#import "addressObject.h"

@implementation adressResolver

-(void)getAddress:(NSString *)baseAdress
{
    NSLog(@"test");
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
         NSLog(@"JSON :%@", responseObject);
         self.results = [NSJSONSerialization
                             JSONObjectWithData:responseObject
                             options:kNilOptions
                             error:&error];
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", [error localizedDescription]);
         _adressArray = nil;
     }];
    [operation start];
}

- (void)addObjectToArray:(NSNumber *)latitude curLongitude:(NSNumber *)longitude address:(NSString *)address city:(NSString *)city
{
    adressObject *addObject = [[adressObject alloc] init];
    [addObject setLat:latitude];
    [addObject setLon:longitude];
    [addObject setCity:city];
    [addObject setAddress:address];
    [_adressArray addObject:addObject];
}

-(void)parseData
{
    NSMutableString *concatAddress = [[NSMutableString alloc] init];
    NSNumber *lat = [[NSNumber alloc] init];
    NSNumber *lon = [[NSNumber alloc] init];
    NSMutableString *city = [[NSMutableString alloc] init];
    
    for (id key in _results)
    {
        [city setString:@""];
        [concatAddress setString:@""];
        [concatAddress appendString:key[@"results"][@"formatted_address"]];
        lat = key[@"results"][@"geometry"][@"lat"];
        lon = key[@"results"][@"geometry"][@"lng"];
        [city appendString:@"lyon"];
        [self addObjectToArray:lat curLongitude:lon address:concatAddress city:city];
    }
}

@end
