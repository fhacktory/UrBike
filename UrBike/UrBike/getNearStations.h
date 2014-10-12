//
//  getNearStations.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getNearStations : NSObject

@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) NSMutableSet *addressArray;

-(void)getNearStations:(NSNumber *)latitude lon:(NSNumber *)longitude;
-(void)parseData;
-(void)addObjectData:(NSString*)name lat:(NSNumber*)latitude lon:(NSNumber*)longitude freespace:(NSNumber*)freespace bikes:(NSNumber*)bikes;
-(void)testAddress;


@end
