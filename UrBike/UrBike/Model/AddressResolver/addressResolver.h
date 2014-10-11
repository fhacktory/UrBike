//
//  adressResolver.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface addressResolver : NSObject

@property (strong, nonatomic) NSMutableString *baseRequest;
@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) NSMutableSet *addressArray;

-(void)parseData;
-(void)getAddress:(NSString*)baseAdress;
- (void)addObjectToArray:(NSNumber *)latitude curLongitude:(NSNumber *)longitude address:(NSString *)address city:(NSString *)city;
-(void)testAddress;
@end
