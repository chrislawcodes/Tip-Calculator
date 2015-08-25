//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Claw on 8/20/15.
//  Copyright (c) 2015 Claw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var beforetaxLabel: UILabel!

    @IBOutlet weak var surchargeControl: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        beforetaxLabel.text = "0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let surchargeRate = 0.04
    let sftaxRate = 0.095
    

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue

        func surchargeCalc () -> Double {
            
            if surchargeControl.on {
                var totaltaxRate = surchargeRate + sftaxRate
                return (totaltaxRate)
            } else {
                var totaltaxRate = sftaxRate
                return (totaltaxRate)
            }

            
        }
        
        var totaltaxRate = surchargeCalc()

        var beforetaxAmount = billAmount / (1 + totaltaxRate)
        var tip = beforetaxAmount * tipPercentage
        var total = billAmount + tip
        
        beforetaxLabel.text = String(format:"$%.2f", beforetaxAmount)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String (format: "$%.2f", total)

        
    }

    @IBAction func onTap(sender: AnyObject)
    {
        view.endEditing(true)
        
    }
}

