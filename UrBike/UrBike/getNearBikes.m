//
//  getNearBikes.m
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import "getNearBikes.h"
#import "nearBikesObject.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@implementation getNearBikes

- (void)getNearBikes:(NSNumber *)latitude lon:(NSNumber *)longitude
{
    self.addressArray = [[NSMutableSet alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://urbike.herokuapp.com/getNearBike"
       parameters:@{@"lat": [latitude stringValue],
                    @"lng": [longitude stringValue]}
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _results = responseObject;
         NSLog(@"%@", _results);
         [self parseData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@", error);
     }];
}

-(void)addObjectData:(NSString *)name lat:(NSNumber *)latitude lon:(NSNumber *)longitude freespace:(NSNumber *)freespace bikes:(NSNumber *)bikes
{
    nearBikesObject *addObject = [[nearBikesObject alloc] init];
    [addObject setLat:latitude];
    [addObject setLon:longitude];
    [addObject setName:name];
    [addObject setFreeSpace:freespace];
    [addObject setBikes:bikes];
    [_addressArray addObject:addObject];
}

-(void)testAddress
{
    NSLog(@"Resultats: %ld", (unsigned long)[_addressArray count]);
//        for (nearBikesObject *key in _addressArray)
//        {
//            NSLog(@"%@, %@, %@, %@, %@", key.name, key.lon, key.lat, key.bikes, key.freeSpace);
//        }
}

-(void)parseData
{
    NSMutableString *name = [[NSMutableString alloc] init];
    NSNumber *lat = [[NSNumber alloc] init];
    NSNumber *lon = [[NSNumber alloc] init];
    NSNumber *freeSpace = [[NSNumber alloc] init];
    NSNumber *bikes = [[NSNumber alloc] init];
    
    for (id key in _results)
    {
        name = key[@"name"];
        lat = key[@"position"][0];
        lon = key[@"position"][1];
        freeSpace = key[@"available_bike_stands"];
        bikes = key[@"available_bikes"];
        [self addObjectData:name lat:lat lon:lon freespace:freeSpace bikes:bikes];
    }
    [self testAddress];
}

@end
