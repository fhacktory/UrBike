//
//  ChoosePlaceViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit

class ChoosePlaceViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputSearchPlace: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.inputSearchPlace.resignFirstResponder()
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
