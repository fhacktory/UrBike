//
//  autoComplete.m
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import "autoComplete.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"

@implementation autoComplete

-(void)getAddress:(NSString *)baseAdress
{
    self.addressArray = [[NSMutableSet alloc] init];
    baseAdress = [baseAdress stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *data = [baseAdress dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    baseAdress = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//  baseAdress = [baseAdress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSLog(@"%@", baseAdress);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://maps.googleapis.com/maps/api/place/autocomplete/json"
       parameters:@{@"types": @"geocode",
                    @"language": @"fr",
                    @"key" : @"AIzaSyCu8Fwx5nSz1TlB6SdPenmZEU1UvwuZmuE",
                    @"sensor" : @"true",
                    @"input" : baseAdress}
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _results = responseObject;
         if ([_results[@"status"] isEqualToString:@"OK"])
         [self parseData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error %@", error);
     }];
}

- (void)addObjectToArray:(NSString *)TextString
{
    [_addressArray addObject:TextString];
}

-(void)parseData
{
    _results = _results[@"predictions"];
    for (id key in _results)
    {
        [self addObjectToArray:key[@"description"]];
    }
    [self testAddress];
}

-(void)testAddress
{
//    NSLog(@"Resultats: %ld", [_addressArray count]);
//    for (NSString *key in _addressArray)
//    {
//        NSLog(@"%@", key);
//    }
}

@end
