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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToMapView(sender: AnyObject) {
        self.performSegueWithIdentifier("showItinaryView", sender: self)
    }

    @IBAction func chooseMode(sender: AnyObject) {
        
        let buttonChecked = sender as UIButton
        
        if buttonChecked == buttonTop {
            buttonTop.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)

        } else if buttonChecked == buttonMiddle {
            
            buttonTop.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
        } else {
            
            buttonTop.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonMiddle.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
            buttonBottom.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
        }
    }

}
