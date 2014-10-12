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
#import "UrBike-Swift.h"

@implementation directions


- (void)getAddress:(NSNumber *)latitude curLongitude:(NSNumber *)curlongitude destlat:(NSNumber *)destlat destlon:(NSNumber *)destlon andViewController:(ItinaryMainViewController *)controller;
{
    self.controller = controller;
    self.addressArray = [[NSMutableSet alloc] init];

    NSMutableString *origin = [[NSMutableString alloc] init];
    NSMutableString *dest = [[NSMutableString alloc] init];
    
    [origin appendFormat:@"%@,%@", [latitude stringValue], [curlongitude stringValue]];
    [dest appendFormat:@"%@,%@", [destlat stringValue], [destlon stringValue]];
    
    NSLog(@"%@ - %@", origin, dest);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://maps.googleapis.com/maps/api/directions/json"
      parameters:@{@"mode": @"bicycling",
                   @"origin": origin,
                   @"destination" : dest,
                   @"key" : @"AIzaSyCu8Fwx5nSz1TlB6SdPenmZEU1UvwuZmuE"}
    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _results = responseObject;
         NSLog(@"%@", _results);
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
    self.encodedPolyline = _results[@"routes"][0][@"overview_polyline"][@"points"];
    self.controller.polyline = [self polylineWithEncodedString:self.encodedPolyline];
    _results = _results[@"routes"][0][@"legs"][0][@"steps"];
    for (id key in _results)
    {
        [self addObjectToArray:key[@"distance"][@"value"] duration:key[@"duration"][@"value"] destlat:key[@"end_location"][@"lat"] destlon:key[@"end_location"][@"lng"] maneuver:key[@"maneuver"]];
    }
    self.controller.listPointsDirection = _addressArray;
    [self.controller drawItinary];
    //[self testAddress];
}


-(void)testAddress
{
        NSLog(@"Resultats: %ld", (unsigned long)[_addressArray count]);
        for (directionsObject *key in _addressArray)
        {
            NSLog(@"------%@ --- %@", key.destlon, key.destlat);
        }
}

- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString {
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        coords[coordIdx++] = coord;
        
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
    free(coords);
    
    return polyline;
}


@end
