//
//  directionsObject.h
//  UrBike
//
//  Created by Apollo on 12/10/14.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface directionsObject : NSObject

@property (strong, nonatomic) NSNumber *distance;
@property (strong, nonatomic) NSNumber *duration;
@property (strong, nonatomic) NSNumber *destlat;
@property (strong, nonatomic) NSNumber *destlon;
@property (strong, nonatomic) NSString *maneuver;


@end
