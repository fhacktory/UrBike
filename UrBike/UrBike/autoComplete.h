//
//  autoComplete.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface autoComplete : NSObject

@property (strong, nonatomic) NSMutableString *baseRequest;
@property (strong, nonatomic) NSMutableDictionary *results;
@property (strong, nonatomic) NSMutableSet *addressArray;

-(void)parseData;
-(void)getAddress:(NSString*)baseAdress;
-(void)addObjectToArray:(NSString*)TextString;
-(void)testAddress;

@end
