//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBOutlet weak var lblMainscreen: UILabel!
    @IBOutlet weak var lblSubscreen: UILabel!
    
    var isCalc = false
    var isEqual = false
    var isFirst = false
    var isSecond = false
    var isFloat = false
    var firstValue:Double = 0.0
    var secondValue:Double = 0.0
    var curVal:String = ""
    var sign:String = ""
    @IBAction func btnClick(_ sender: UIButton) {
        
        let btnValue = sender.titleLabel!.text!
        print(btnValue)
        
        switch btnValue {
        case "+", "-", "×", "÷" :
            if(isCalc == true){
                lblSubscreen.text = "\(Double(firstValue).removeZerosFromEnd()) \(btnValue) "
                curVal = ""
                lblMainscreen.text = "0"
            }
            else{
                lblSubscreen.text = "\(Double(curVal)!.removeZerosFromEnd()) \(btnValue) "
                firstValue = Double("\(curVal)")!
                curVal = ""
                lblMainscreen.text = "0"
                isCalc = true
                isEqual = true
            }
            sign = btnValue

            print("Calc")
        case "=" :
            if(isCalc == true){
                lblSubscreen.text = "\(lblSubscreen.text!)\(curVal)"
                secondValue = Double("\(curVal)")!
                isEqual = false
                isCalc = false
                curVal = calResult(s: sign)
                lblMainscreen.text = "\(curVal)"
                if (curVal == "INIT"){
                    clear()
                }
            }
            else{
                print("Do Nothing")
            }
        case "C" :
            print("Clear")
            lblMainscreen.text = "0"
            lblSubscreen.text = ""
            clear()
        case "+/-" :
            print("Change +/-")
            curVal = changeVal(a: (curVal as NSString).doubleValue)
            lblMainscreen.text = Double(curVal)?.removeZerosFromEnd()
        case "%" :
            print("Percent Tag")
            curVal = perc(a: (curVal as NSString).doubleValue)
            lblMainscreen.text = Double(curVal)?.removeZerosFromEnd()
        case "." :
            isFloat = true
            fallthrough
        default:
            curVal = "\(curVal)\(btnValue)"
            lblMainscreen.text = Double(curVal)?.removeZerosFromEnd()
        }
    }
    
    func calResult(s : String)->String{
        switch s {
        case "+":
            print("Plus")
            return Double(Sum(a: firstValue, b: secondValue))!.removeZerosFromEnd()
        case "-":
            print("Minus")
            return Double(Minus(a: firstValue, b: secondValue))!.removeZerosFromEnd()
        case "×":
            print("Multi")
            return Double(Multi(a: firstValue, b: secondValue))!.removeZerosFromEnd()
        case "÷":
            print("Div")
            let res = Div(a: firstValue, b: secondValue);
            if(res == "INIT"){
                return res
            }
            else{
                return Double(res)!.removeZerosFromEnd()
            }
        default:
            return "None"
        }
    }
    
    func Sum (a : Double, b : Double) -> String{
        return "\(a + b)"
    }
    
    func Minus (a : Double, b : Double) -> String{
        return "\(a - b)"
    }
    
    func Multi (a : Double, b : Double) -> String{
        if (a == 0 || b == 0){
            return "0"
        }
        else{
            return "\(a * b)"
        }
    }
    
    func Div (a : Double, b : Double) -> String{
        if (a == 0){
            return "0"
        }
        else if (b == 0){
            return "INIT"
        }
        else{
            return "\(a/b)"
        }
    }
    
    func perc (a : Double) -> String{
        if(a == 0){
            return "0"
        }
        else{
            return "\(a/100)"
        }
    }
    
    func changeVal (a : Double) -> String{
        if(a == 0){
            return "0"
        }
        else{
            return "\(-1*a)"
        }
    }
    
    func clear () -> Void{
        isCalc = false
        isEqual = false
        isFirst = false
        isSecond = false
        isFloat = false
        firstValue = 0.0
        secondValue = 0.0
        curVal = "0"
        sign = ""
    }
    
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
