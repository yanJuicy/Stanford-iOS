//
//  ViewController.swift
//  Calculator
//
//  Created by a on 2024/01/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
//        let digit = sender.titleLabel?.text
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathMaticalSymbol = sender.currentTitle {
            if mathMaticalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
        
    }
    
}

