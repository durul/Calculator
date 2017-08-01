//
//  ViewController.swift
//  Calculator

import UIKit

class ViewController: UIViewController {
    
    var labelString:String = "0"
    var currentMode:Modes = Modes.not_SET
    var savedNum:Int64 = 0
    var lastButtonWasMode:Bool = false
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapped0(_ sender: AnyObject) {tappedNumber(0)}
    @IBAction func tapped1(_ sender: AnyObject) {tappedNumber(1)}
    @IBAction func tapped2(_ sender: AnyObject) {tappedNumber(2)}
    @IBAction func tapped3(_ sender: AnyObject) {tappedNumber(3)}
    @IBAction func tapped4(_ sender: AnyObject) {tappedNumber(4)}
    @IBAction func tapped5(_ sender: AnyObject) {tappedNumber(5)}
    @IBAction func tapped6(_ sender: AnyObject) {tappedNumber(6)}
    @IBAction func tapped7(_ sender: AnyObject) {tappedNumber(7)}
    @IBAction func tapped8(_ sender: AnyObject) {tappedNumber(8)}
    @IBAction func tapped9(_ sender: AnyObject) {tappedNumber(9)}
    
    @IBAction func tappedEquals(_ sender: AnyObject) {
        guard let num:Int64 = Int64(labelString) else {
            return
        }
        
        if currentMode == Modes.not_SET || lastButtonWasMode {
            return
        }
        
        if currentMode == Modes.addition {
            savedNum += num
        }
        
        else if currentMode == Modes.subtraction {
            savedNum -= num
        }
        
        else if currentMode == Modes.multiplication {
            savedNum *= num
        }
        
        currentMode = Modes.not_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    

    func tappedNumber(_ num:Int) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString + "\(num)"
        updateText()
    }
    
    func updateText() {
        guard let labelInt:Int64 = Int64(labelString) else {
            label.text = "Int conversion failed"
            return
        }
        
//        if currentMode == modes.not_SET {
//            savedNum = labelInt
//        }
        
        savedNum = (currentMode == Modes.not_SET) ? labelInt : savedNum
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let num:NSNumber = NSNumber(value: labelInt as Int64)
        label.text = formatter.string(from: num)
    }
    
    func changeMode(_ newMode:Modes) {
        if savedNum == 0 {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    @IBAction func tappedClear(_ sender: AnyObject) {
        savedNum = 0
        labelString = "0"
        label.text = "0"
        currentMode = Modes.not_SET
        lastButtonWasMode = false
    }
    
    @IBAction func tappedPlus(_ sender: AnyObject) {
        changeMode(Modes.addition)
    }
    
    @IBAction func tappedMinus(_ sender: AnyObject) {
        changeMode(Modes.subtraction)
    }
    
    @IBAction func tappedMultiply(_ sender: AnyObject) {
        changeMode(Modes.multiplication)
    }
    
}

