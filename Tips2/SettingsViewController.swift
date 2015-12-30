//
//  SettingsViewController.swift
//  Tips2
//
//  Created by Jesus Acevedo on 12/29/15.
//  Copyright © 2015 Jesus Acevedo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pctSlider: UISlider!
    @IBOutlet weak var pctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let doubleValue = Float(defaults.doubleForKey("default_tip_pct"))
        pctSlider.value = (doubleValue != 0) ? doubleValue : 10.0
        pctLabel.text = "\(Int(doubleValue))%"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //@IBAction func onEditDefaultTip(sender: UISegmentedControl) {
        
     //   let defaults = NSUserDefaults.standardUserDefaults()
        
     //   defaults.setInteger(sender.selectedSegmentIndex, forKey: "default_tip")
     //   defaults.synchronize()
   // }
    
    @IBAction func tipPctChanged(sender: AnyObject) {
        let tipSlider = Int(pctSlider.value)
        pctLabel.text = "\(tipSlider)%"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(Double(tipSlider), forKey: "default_tip_pct")
        defaults.synchronize()
    }

}