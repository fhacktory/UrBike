//
//  directions.h
//  UrBike
//
//  Created by Apollo on 12/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "directionsObject.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"


@class ItinaryMainViewController;

@interface directions : NSObject

@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) NSMutableArray *steps;
@property (strong, nonatomic) NSMutableSet *addressArray;
@property (strong, nonatomic) ItinaryMainViewController *controller;
@property (strong, nonatomic) NSString *encodedPolyline;

-(void)parseData;
- (void)getAddress:(NSNumber *)latitude curLongitude:(NSNumber *)curlongitude destlat:(NSNumber *)destlat destlon:(NSNumber *)destlon andViewController:(ItinaryMainViewController *)controller;
-(void)addObjectToArray:(NSNumber *)distance duration:(NSNumber *)duration destlat:(NSNumber *)destlat destlon:(NSNumber *)destlon maneuver:(NSString*)maneuver;
-(void)testAddress;


@end
