//
//  adressResolver.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@class ChoosePlaceViewController;


@interface addressResolver : NSObject

@property (strong, nonatomic) NSMutableString *baseRequest;
@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) NSMutableSet *addressArray;
@property (strong, nonatomic) ChoosePlaceViewController *controller;

-(void)parseData;
-(void)getAddress:(NSString *)baseAdress andViewController:(ChoosePlaceViewController *)controller;
- (void)addObjectToArray:(NSNumber *)latitude curLongitude:(NSNumber *)longitude address:(NSString *)address city:(NSString *)city;
-(void)testAddress;
@end
