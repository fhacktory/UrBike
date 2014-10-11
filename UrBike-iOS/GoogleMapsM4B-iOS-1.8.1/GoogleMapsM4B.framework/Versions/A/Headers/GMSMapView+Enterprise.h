//
//  GMSMapView+Enterprise.h
//  Google Maps SDK for iOS
//
//  Copyright 2013 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <GoogleMapsM4B/GMSMapView.h>


/**
 * This interface may be used in place of GMSMapViewDelegate as the map view
 * delegate property in order to be notified of additional enterprise specific
 * events.
 */
@protocol GMSEnterpriseMapViewDelegate <GMSMapViewDelegate>
@optional

/**
 * Called after one or more Google Maps Engine layers have been tapped.
 * Features returned by this method will not be fully populated, but it will be called as soon as
 * the tap has occurred.
 * All features under the tap are reported, in a prioritized order.
 *
 * @param mapView The map view that was pressed.
 * @param features Array of GMSMapsEngineFeature instances with initial details.
 */
- (void)mapView:(GMSMapView *)mapView
    didTapFeatures:(NSArray *)features;

/**
 * Called after one or more Google Maps Engine layers have been tapped and the features have been
 * resolved to provide additional information.
 * All features under the tap are reported, in a prioritized order.
 *
 * @param mapView The map view that was pressed.
 * @param features The same array as returned by the corresponding mapView:didTapFeatures: call,
 * but with all available information now populated in the internal instances.
 */
- (void)mapView:(GMSMapView *)mapView
    didResolveFeatures:(NSArray *)features;

@end
