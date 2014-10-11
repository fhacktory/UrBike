//
//  SplashScreenViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var addr = autoComplete();
        addr.getAddress("Liberte");
//        var addr = getNearStations();
//        var lat = 45.757150
//        var lon = 4.842739
//        addr.getNearStations(lat, lon: lon);
////        var addr = addressResolver()
////        addr.getAddress("61rueliberte")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkEnabledToUseApplication() {
        
        if ReachabilityToolBox.hasConnectivity() {
            
            
            
        } else {
            
            let alert = SCLAlertView()
            
            alert.addButton("Quitter l'application") {
                println("clicked")
                exit(0)
            }
            
            alert.showError(self, title: "Ouuups", subTitle: "Vous n'avez pas de connexion internet.")
            
        }
    }
    

}
