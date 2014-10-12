//
//  ChoosePlaceViewController.swift
//  UrBike
//
//  Created by Rebouh Aymen on 11/10/2014.
//  Copyright (c) 2014 UrBike. All rights reserved.
//

import UIKit

class ChoosePlaceViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inputSearchPlace: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var listAddressAutocomplete: NSMutableSet?
    let addr = addressResolver()
    override func viewDidLoad() {
        super.viewDidLoad()
        let addr = addressResolver()
        addr.getAddress("Cours de la ", andViewController: self)
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("index section == \(indexPath.section)")
        var cell: UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell
        
        if self.listAddressAutocomplete != nil {
            cell!.textLabel!.text = (self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).address
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.listAddressAutocomplete != nil {
            return self.listAddressAutocomplete!.count
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    func printData() {
        
        if self.listAddressAutocomplete != nil {
        

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println("CLICK")
        self.tableView.hidden = false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var searchStr = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        addr.getAddress(searchStr, andViewController: self)

        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.inputSearchPlace.text =  (self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).address
        let lat = (self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).lat.floatValue
        let long = (self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).lon.floatValue
        self.tableView.hidden = true
        NSUserDefaults.standardUserDefaults().setObject((self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).address, forKey: "place")
        NSUserDefaults.standardUserDefaults().setObject((self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).lat.floatValue, forKey: "lat")
        NSUserDefaults.standardUserDefaults().setObject((self.listAddressAutocomplete!.allObjects[indexPath.row] as addressObject).lon.floatValue, forKey: "lon")

    }


}
