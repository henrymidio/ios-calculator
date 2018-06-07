//
//  ViewController.swift
//  Calculator
//
//  Created by Usuario on 18/09/17.
//  Copyright © 2017 MobTime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var brain = CalculatorBrain()
    
    var isUserInTheMiddleTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if(!isUserInTheMiddleTyping) {
            display.text = digit
            isUserInTheMiddleTyping = true
        } else {
            display.text = display.text! + digit
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        isUserInTheMiddleTyping = false
        let symbol = sender.currentTitle!
        brain.performOperation(symbol, displayValue)
        displayValue = brain.result!
        
        if(symbol == "=") {
            brain.clear()
        }
    }
    
}

