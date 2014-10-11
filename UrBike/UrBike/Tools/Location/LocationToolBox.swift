//
//  LocationToolBox.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//



import Foundation
import MapKit

var userLocation: CLLocationManager?

class LocationToolBox {
    
    class func setupUserLocation() {
        

        
        userLocation = CLLocationManager()
        userLocation!.delegate = UIApplication.sharedApplication().delegate! as AppDelegate
        userLocation!.desiredAccuracy = kCLLocationAccuracyBest
        userLocation!.distanceFilter = kCLDistanceFilterNone
        
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0 {
            self.getUserLocation()!.requestAlwaysAuthorization()
        }
        
        userLocation!.startUpdatingLocation()

    }
    
    
    class func printStateLocation() {
        
        if self.locationWorking() {
            println("Location ok")
        } else {
            println("Location non ok")
        }
    }
    
    class func getUserLocation() -> CLLocationManager? {
        return userLocation
    }
    
    class func locationWorking() -> Bool {
        
        if  let myLocation = userLocation?  {
            
            if let coordinate = myLocation.location?.coordinate  {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    
}