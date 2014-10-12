//
//  MyCoffeeAnnotation.swift
//  Coffee Around
//
//  Created by Rebouh Aymen on 06/09/2014.
//  Copyright (c) 2014 Rebouh Aymen. All rights reserved.
//

import UIKit
import MapKit

class MyBikeAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String

    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title =  title
        self.coordinate = coordinate

    }
}

