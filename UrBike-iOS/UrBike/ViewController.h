//
//  ViewController.h
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 com.UrBike. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <GoogleMapsM4B/GoogleMaps.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) GMSMapView *mapView_;

@property (strong, nonatomic) GMSCameraPosition *camera;
@property (strong, nonatomic) NSMutableString *APIKey;
@property (strong, nonatomic) NSMutableSet *markers;

@end

