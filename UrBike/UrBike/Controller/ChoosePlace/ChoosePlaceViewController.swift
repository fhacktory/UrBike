//
//  ChoosePlaceViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit

class ChoosePlaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = directions();
        test.getAddress(45.760996, curLongitude: 4.857910, destlat: 45.770487, destlon: 4.863274)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goChooseTransportMode(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToChooseTransportModeView", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
