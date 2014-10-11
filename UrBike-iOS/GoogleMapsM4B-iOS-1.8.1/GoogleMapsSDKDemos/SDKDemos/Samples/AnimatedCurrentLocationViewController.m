#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/Samples/AnimatedCurrentLocationViewController.h"

@implementation AnimatedCurrentLocationViewController {
  CLLocationManager *manager_;
  GMSMapView        *mapView_;
  GMSMarker         *locationMarker_;

}

- (void)viewDidLoad {
  [super viewDidLoad];

  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.8879
                                                          longitude:-77.0200
                                                               zoom:17];
  mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  mapView_.settings.myLocationButton = NO;
  mapView_.settings.indoorPicker = NO;

  self.view = mapView_;

  // Setup location services
  if (![CLLocationManager locationServicesEnabled]) {
    NSLog(@"Please enable location services");
    return;
  }

  if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
    NSLog(@"Please authorize location services");
    return;
  }

  manager_ = [[CLLocationManager alloc] init];
  manager_.delegate = self;
  manager_.desiredAccuracy = kCLLocationAccuracyBest;
  manager_.distanceFilter = 5.0f;
  [manager_ startUpdatingLocation];

}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
    NSLog(@"Please authorize location services");
    return;
  }

  NSLog(@"CLLocationManager error: %@", error.localizedFailureReason);
  return;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  CLLocation *location = [locations lastObject];

  if (locationMarker_ == nil) {
    locationMarker_ = [[GMSMarker alloc] init];
    locationMarker_.position = CLLocationCoordinate2DMake(-33.86, 151.20);

    // Animated walker images derived from an www.angryanimator.com tutorial.
    // See: http://www.angryanimator.com/word/2010/11/26/tutorial-2-walk-cycle/

    NSArray *frames = @[[UIImage imageNamed:@"step1"],
                        [UIImage imageNamed:@"step2"],
                        [UIImage imageNamed:@"step3"],
                        [UIImage imageNamed:@"step4"],
                        [UIImage imageNamed:@"step5"],
                        [UIImage imageNamed:@"step6"],
                        [UIImage imageNamed:@"step7"],
                        [UIImage imageNamed:@"step8"]];

    locationMarker_.icon = [UIImage animatedImageWithImages:frames duration:0.8];
    locationMarker_.groundAnchor = CGPointMake(0.5f, 0.97f); // Taking into account walker's shadow
    locationMarker_.map = mapView_;
  } else {
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    locationMarker_.position = location.coordinate;
    [CATransaction commit];
  }

  GMSCameraUpdate *move = [GMSCameraUpdate setTarget:location.coordinate zoom:17];
  [mapView_ animateWithCameraUpdate:move];
}


@end
