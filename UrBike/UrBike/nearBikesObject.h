//
//  nearBikesObject.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nearBikesObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSNumber *freeSpace;
@property (nonatomic, strong) NSNumber *bikes;

@end
