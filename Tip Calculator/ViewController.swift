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
    
    @IBOutlet weak var firstView: UIView!

    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var taxincludedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        beforetaxLabel.text = "0.00"
        billField.becomeFirstResponder()


         UIView.animateWithDuration(0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.firstView.alpha = 1
            self.secondView.alpha = 0
                   })
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseOut, animations: {
            var billFieldFrame = self.billField.frame
            billFieldFrame.origin.y = 150
            
            self.billField.frame = billFieldFrame
            }, completion: { finished in
                println("Moved the Bill Field First!")
        })

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditStart(sender: UITextField) {
       
    }

    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
            var billFieldFrame = self.billField.frame
            billFieldFrame.origin.y = 30
            self.billField.frame = billFieldFrame
            }, completion: { finished in
                
            })
        
        //  show tip control and show other elements when the user edits
        
        UIView.animateWithDuration(0.5,animations: {
            self.secondView.alpha = 1
            self.tipControl.alpha = 1
            println("Faded In")
            })
        
        //setup the amount that taxes are charged
        let surchargeRate = 0.04
        var sftaxRates = [0.0,0.095]
        var sftaxRate = sftaxRates[taxincludedControl.selectedSegmentIndex]

        //tip calculation
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue

        //this function decides if there is a health surcharge included in the taxes.
        func surchargeCalc () -> Double {
            
            if surchargeControl.on {
                var totaltaxRate = surchargeRate + sftaxRate
                println(sftaxRate)
                return (totaltaxRate)
            } else {
                var totaltaxRate = sftaxRate
                println(sftaxRate)
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

