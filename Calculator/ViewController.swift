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
    var isFloat = false
    var firstValue:Double = 0.0
    var secondValue:Double = 0.0
    var curVal:String = "0"
    var sign:String = ""
    @IBAction func btnClick(_ sender: UIButton) {
        
        let btnValue = sender.titleLabel!.text!
        print(btnValue)
        
        switch btnValue {
        case "+", "-", "×", "÷" :
            if curVal == "inf"{
                //Do nothing when inf show up
                break
            }
            if (isCalc){
                // if user click equation two or more times
                lblSubscreen.text = "\(Double(firstValue).removeZerosFromEnd()) \(btnValue) "
                curVal = "0"
                lblMainscreen.text = "0"
            }
            else{
                lblSubscreen.text = "\(Double(curVal)!.removeZerosFromEnd()) \(btnValue) "
                firstValue = Double("\(curVal)")!
                curVal = "0"
                lblMainscreen.text = "0"
                isCalc = true
                isEqual = false
            }
            sign = btnValue
            isFloat = false
            print("Calc")
        case "=" :
            if (curVal == "inf"){
                break
            }
            if(isCalc == true && isEqual == false){
                //when user click equation and then not yet click equal sign
                lblSubscreen.text = "\(lblSubscreen.text!)\(Double(curVal)!.removeZerosFromEnd())"
                secondValue = Double("\(curVal)")!
                isEqual = true
                isCalc = false
                isFloat = false
                curVal = calResult(Equation: sign)
                lblMainscreen.text = "\(curVal)"
            }
            else{
                //when user clicked equal two or more time with click number or other equation
                print("Do Nothing")
            }
        case "C" :
            print("Clear")
            clear()
        case "+/-" :
            if (curVal == "inf"){
                break
            }
            print("Change +/-")
            curVal = Double(changeVal(a: (curVal as NSString).doubleValue))!.removeZerosFromEnd()
            lblMainscreen.text = "\(curVal)"
        case "%" :
            if (curVal == "inf"){
                break
            }
            print("Percent Tag")
            curVal = perc(a: (curVal as NSString).doubleValue)
            lblMainscreen.text = Double(curVal)?.removeZerosFromEnd()
        case "." :
            if (isCalc == false && isEqual == true){
                clear()
            }
            
            if (curVal == "inf"){
                break
            }
            if (floor((curVal as NSString).doubleValue) == (curVal as NSString).doubleValue && !isFloat){
                curVal = "\(curVal)."
                lblMainscreen.text = "\(curVal)"
                isFloat = true
            }
        default:
            if (curVal.count > 10){
                break
            }
            if (isCalc == false && isEqual == true){
                clear()
            }
            if (curVal == "inf"){
                clear()
            }
            if (curVal == "0"){
                curVal = "\(btnValue)"
            }
            else{
                curVal = "\(curVal)\(btnValue)"
            }
            lblMainscreen.text = "\(curVal)"
        }
    }
    
    //Switch For Equation Sign
    func calResult(Equation s : String)->String{
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
            if (res == "inf"){
                // if return result is inf, we return it otherwise, remove zero from the end
                return res
            }
            else{
                return Double(res)!.removeZerosFromEnd()
            }
        default:
            return "None"
        }
    }
    //End Switch Equation Sign
    
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
        if (b == 0){
            return "inf"
        }
        else{
            return "\(a/b)"
        }
    }
    
    func perc (a : Double) -> String{
        if (a == 0){
            return "0"
        }
        else{
            return "\(a/100)"
        }
    }
    
    func changeVal (a : Double) -> String{
        if (a == 0){
            return "0"
        }
        else{
            return "\(-1*a)"
        }
    }
    
    func clear () -> Void{
        lblMainscreen.text = "0"
        lblSubscreen.text = ""
        isCalc = false
        isEqual = false
        isFloat = false
        firstValue = 0.0
        secondValue = 0.0
        curVal = "0"
        sign = ""
    }
// End class ViewController
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9 //maximum digits in Double after dot (maximum precision)
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
