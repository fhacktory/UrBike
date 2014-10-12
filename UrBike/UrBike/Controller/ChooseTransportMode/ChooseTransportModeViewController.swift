//
//  ChooseTransportModeViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit

class ChooseTransportModeViewController: UIViewController {

    @IBOutlet weak var buttonTop: UIButton!
    @IBOutlet weak var buttonMiddle: UIButton!
    @IBOutlet weak var buttonBottom: UIButton!
    var indexButtonChecked = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let place = NSUserDefaults.standardUserDefaults().objectForKey("place") as String
        let lat = NSUserDefaults.standardUserDefaults().objectForKey("lat") as Float

        println("PLACE CHOISI == \(place) et lat = \(lat)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToMapView(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(self.indexButtonChecked, forKey: "indexButton")
        self.performSegueWithIdentifier("showItinaryView", sender: self)
    }

    @IBAction func chooseMode(sender: AnyObject) {
        
        let buttonChecked = sender as UIButton
        
        if buttonChecked == buttonTop {
            self.indexButtonChecked = 0
            buttonTop.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)

        } else if buttonChecked == buttonMiddle {
            self.indexButtonChecked = 1
            buttonTop.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
        } else {
            self.indexButtonChecked = 2
            buttonTop.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
        }
    }

}
