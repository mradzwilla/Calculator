//
//  ViewController.swift
//  Calculator
//
//  Created by Michael Radzwilla on 2/6/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
        let textCurrentlyInDisplay = display.text!
        display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func touchDecimal(_ sender: UIButton) {
        let currentNumberInDisplay = displayValue
        let isInteger = floor(currentNumberInDisplay) == currentNumberInDisplay
        
        if isInteger == true {
            display.text = "\(Int(currentNumberInDisplay))."
        }
        userIsInTheMiddleOfTyping = true

    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func clear(_ sender: Any) {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
        brain.clear()
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
        }
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

