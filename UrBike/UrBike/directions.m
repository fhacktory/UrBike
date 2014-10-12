//
//  directions.m
//  UrBike
//
//  Created by Apollo on 12/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import "directions.h"
#import "directionsObject.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"

@implementation directions

- (void)getAddress:(NSNumber *)latitude curLongitude:(NSNumber *)curlongitude destlat:(NSNumber *)destlat destlon:(NSNumber *)destlon
{
    self.addressArray = [[NSMutableSet alloc] init];
    NSMutableString *origin = [[NSMutableString alloc] init];
    NSMutableString *dest = [[NSMutableString alloc] init];
    
    [origin appendFormat:@"%@,%@", [latitude stringValue], [curlongitude stringValue]];
    [dest appendFormat:@"%@,%@", [destlat stringValue], [destlon stringValue]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://maps.googleapis.com/maps/api/directions/json"
      parameters:@{@"mode": @"bicycling",
                   @"origin": origin,
                   @"destination" : dest,
                   @"key" : @"AIzaSyCu8Fwx5nSz1TlB6SdPenmZEU1UvwuZmuE"}
    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _results = responseObject;
         if ([_results[@"status"] isEqualToString:@"OK"]) {
             [self parseData];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@", error);
     }];
}

-(void)addObjectToArray:(NSNumber *)distance duration:(NSNumber *)duration destlat:(NSNumber *)destlat destlon:(NSNumber *)destlon maneuver:(NSString *)maneuver
{
    directionsObject *obj = [[directionsObject alloc] init];
    [obj setManeuver:maneuver];
    [obj setDestlat:destlat];
    [obj setDestlon:destlon];
    [obj setDistance:distance];
    [obj setDuration:duration];
    [_addressArray addObject:obj];
}

-(void)parseData
{
    _results = _results[@"routes"][0][@"legs"][0][@"steps"];
    
    for (id key in _results)
    {
        [self addObjectToArray:key[@"distance"][@"value"] duration:key[@"duration"][@"value"] destlat:key[@"end_location"][@"lat"] destlon:key[@"end_location"][@"lng"] maneuver:key[@"maneuver"]];
    }
//[self testAddress];
}

-(void)testAddress
{
        NSLog(@"Resultats: %ld", (unsigned long)[_addressArray count]);
        for (directionsObject *key in _addressArray)
        {
            NSLog(@"%@", key);
        }
}


@end
