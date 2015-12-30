//
//  ViewController.swift
//  Tips2
//
//  Created by Eduardo Nieves on 12/29/15.
//  Copyright © 2015 JEduardo Nieves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    @IBOutlet weak var splitField: UITextField!
    @IBOutlet weak var totalPersonLabel: UILabel!
    @IBOutlet weak var tipPersonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalPersonLabel.text = "$0.00"
        tipPersonLabel.text = "$0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
    }
    
    
    func updateTip() {
        let tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage : Double = (tipPercentageControl.selectedSegmentIndex != UISegmentedControlNoSegment) ? tipPercentages[tipPercentageControl.selectedSegmentIndex] :   NSUserDefaults.standardUserDefaults().doubleForKey("default_tip_pct")
        let moneyFormatString = "$%.2f"
        
        if((tipPercentage == 0.18)||(tipPercentage == 0.2)||(tipPercentage == 0.22)){
            tipPercentage = tipPercentage*100
        }
        
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage / 100
        let total = billAmount + tip
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        let split = (splitField.text! as NSString).doubleValue
        let totalPerson = total/split
        let tipPerson = tip/split
        
        totalPersonLabel.text = formatter.stringFromNumber(totalPerson)
        
        if splitField.text!.isEmpty
        {
            totalPersonLabel.text = String(format: moneyFormatString, "0.00")
            tipPersonLabel.text = String(format: moneyFormatString, "0.00")           }
        else{
            totalPersonLabel.text =  formatter.stringFromNumber(totalPerson)
            tipPersonLabel.text =  formatter.stringFromNumber(tipPerson)     }
    }
    
    
    @IBAction func splitEditingChanged(sender: AnyObject) {
        updateSplit()
    }
    
    func updateSplit(){
        
        let tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage : Double = (tipPercentageControl.selectedSegmentIndex != UISegmentedControlNoSegment) ? tipPercentages[tipPercentageControl.selectedSegmentIndex] :   NSUserDefaults.standardUserDefaults().doubleForKey("default_tip_pct")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        let moneyFormatString = "$%.2f"
        
        if((tipPercentage == 0.18)||(tipPercentage == 0.2)||(tipPercentage == 0.22)){
            tipPercentage = tipPercentage*100
        }
        
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage / 100
        let total = billAmount + tip
        
        let split = (splitField.text! as NSString).doubleValue
        let totalPerson = total/split
        let tipPerson = tip/split
        
        
        if splitField.text!.isEmpty
        {
            totalPersonLabel.text = String(format: moneyFormatString, "$0.00")
            tipPersonLabel.text = String(format: moneyFormatString, "$0.00")        }
        else{
            totalPersonLabel.text =  formatter.stringFromNumber(totalPerson)
            tipPersonLabel.text =  formatter.stringFromNumber(tipPerson)
            
        }
        
    }
    
    
    func onTap(sender: AnyObject) {
        view.endEditing(true)
        updateTip()
        updateSplit()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        billField.becomeFirstResponder()
        tipPercentageControl.selectedSegmentIndex = UISegmentedControlNoSegment
        updateTip()  //updates everytime ViewController screen is opened
        updateSplit()//updates everytime ViewController screen is opened
    }
    
}
