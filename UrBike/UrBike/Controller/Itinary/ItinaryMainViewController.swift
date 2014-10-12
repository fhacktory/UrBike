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
    var listAddressAutocomplete: NSMutableSet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.userLocation.title = "I'm here !"
        
        if LocationToolBox.locationWorking() {
            let mapRegion = MKCoordinateRegionMakeWithDistance(LocationToolBox.getUserLocation()!.location.coordinate, 500, 500)
            self.mapView.setRegion(mapRegion, animated: true)
        }
        
        let addr = addressResolver()
        addr.getAddress("La cordée", andViewController: self)
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "vibrate", userInfo: nil, repeats: true)
    }
    
    func printData() {
        
        println("AYMEN TEST \(listAddressAutocomplete!)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate) );
    }
    
}
