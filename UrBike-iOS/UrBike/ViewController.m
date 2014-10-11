//
//  ViewController.m
//  UrBike
//
//  Created by Apollo on 11/10/14.
//  Copyright (c) 2014 com.UrBike. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <GMSMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.camera = [GMSCameraPosition cameraWithLatitude:45.755038
                                              longitude:4.85
                                                   zoom:15];
    self.mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    self.mapView_.delegate = self;
//    self.view = self.mapView_;
//    self.mapView_.mapType = kGMSTypeNormal;
//    self.mapView_.settings.compassButton = YES;
//    self.mapView_.settings.myLocationButton = YES;
//    self.APIKey = [[NSMutableString alloc] init];
//    [self.APIKey appendString:@"&apiKey=330ce071949ce010e76b00671a988f6dd2791933"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
