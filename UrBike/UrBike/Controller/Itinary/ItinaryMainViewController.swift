//
//  ItinaryMainViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit
import MapKit
import AudioToolbox

class ItinaryMainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UISearchControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var listPointsDirection: NSMutableSet?
    var a = [LocationToolBox.getUserLocation()!.location.coordinate];
    let direction = directions()
    var polyline: MKPolyline!
    override func viewDidLoad() {
        super.viewDidLoad()

        let indexChecked = NSUserDefaults.standardUserDefaults().objectForKey("indexButton") as Int
        
        if indexChecked == 0 {
            self.showItinaryToDestination()
        }
        self.mapView.delegate = self
        self.mapView.userLocation.title = "Vous êtes ici !"
        let olat = (LocationToolBox.getUserLocation()!.location.coordinate.latitude as Double)
        let olong = (LocationToolBox.getUserLocation()!.location.coordinate.longitude as Double)
        let nlat: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("lat")
        let nlong: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("lon")
        direction.getAddress(olat, curLongitude: olong, destlat: nlat as NSNumber, destlon: nlong as NSNumber, andViewController: self)
        if LocationToolBox.locationWorking() {
            let mapRegion = MKCoordinateRegionMakeWithDistance(LocationToolBox.getUserLocation()!.location.coordinate, 500, 500)
            self.mapView.setRegion(mapRegion, animated: true)
        }
        
        
/*        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "vibrate", userInfo: nil, repeats: true)*/
    }


    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let identifier = "DestinationPoint"
        
        if annotation is MyBikeAnnotation {
            
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                annotationView!.annotation = annotation
            }
            
            annotationView!.enabled = true
            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            
            return annotationView!
        }
        
        return nil
    }
    
    
    func showItinaryToDestination() {
        
        let coordonnee: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: NSUserDefaults.standardUserDefaults().objectForKey("lat") as Double, longitude: NSUserDefaults.standardUserDefaults().objectForKey("lon") as Double)

        let title = NSUserDefaults.standardUserDefaults().objectForKey("place") as String
        let myDestinationAnnotation: MyBikeAnnotation = MyBikeAnnotation(title: title,  coordinate: coordonnee)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.mapView.addAnnotation(myDestinationAnnotation)
            //self.drawItinary()
        })
    }
    
    func drawBetweenTwoPts()
    {
    dispatch_async(dispatch_get_main_queue(), {
        self.mapView.addOverlay(self.polyline);
    })}

    func drawItinary()
    {
        var test = 0
        var lat = 0.0
        var lon = 0.0
        for elem  in self.listPointsDirection!
        {
            lat = (elem as directionsObject).destlat
            lon = (elem as directionsObject).destlon
            let c1 = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
            println("\(lat), \(lon)")
            self.a.append(c1)
            
            let coordonnee: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            var title = (elem as directionsObject).maneuver

            if title == nil {
                title = ""
            } else if title == "turn-right" {
                title = "Tourner à droite"
            } else {
                title = "Tourner à gauche"
            }
                let myDestinationAnnotation: MyBikeAnnotation = MyBikeAnnotation(title: title,  coordinate: coordonnee)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.mapView.addAnnotation(myDestinationAnnotation)
                //self.drawItinary()
            })
        }
        drawBetweenTwoPts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        var polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blueColor()
        polylineRenderer.lineWidth = 3
        return polylineRenderer
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate) );
    }
    

    
}
