//
//  ViewController.swift
//  calculator_Bek
//
//  Created by Berkay YAY on 28.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var calculatorLabel: UILabel!
    
    @IBOutlet private weak var resultLabel: UILabel!
    
    var sum = ""
    var numbers: String = ""
    var operation: String = ""
    var equalTapped = false
    var count = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll(){
        number1 = ""
        numbers = ""
        calculatorLabel.text = ""
        resultLabel.text = ""
        newOperation = true
        operation = ""
        count = 0
        sum = ""
    }
    
    func doCalculations(number1: String, number2: String, operation: String) -> Double{
        guard let num1 = Double(number1),
              let num2 = Double(number2) else{
            return .zero
        }
        switch operation{
        case "*":
            return Double(num1) * Double(num2)
        case "/":
            return Double(num1) / Double(num2)
        case "+":
            return Double(num1) + Double(num2)
        case "-":
            return Double(num1) - Double(num2)
        default:
            return .zero
        }
    }
    
    var newOperation = true
    var number1: String?
    func addToScreen(val: String){
        guard calculatorLabel.text != nil else {
            return
        }
        if newOperation && count == 1{
            number1 = numbers
            numbers = ""
            newOperation = false
                        
        }
        else if newOperation && count == 2{
            guard let num1 = number1 else{
                return
            }
            number1 = "\(doCalculations(number1: num1, number2: numbers, operation: operation))"
            numbers = ""
            newOperation = false
            count = 1
        }
        numbers += val
        calculatorLabel.text = numbers
        
        
        
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearAll()
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if !numbers.isEmpty{
            numbers.removeLast()
            calculatorLabel.text = numbers
        }
    }
    
    @IBAction func numericButtonTapped(_ sender: UIButton) {
        guard let text = sender.currentTitle,
              calculatorLabel.text != nil else{
            return
        }
        if equalTapped{
            calculatorLabel.text = ""
            addToScreen(val: text)
            equalTapped = false
        }else{
            addToScreen(val: text)
        }
        
    }
    
  
    
    @IBAction func equalButtonTapped(_ sender: UIButton){
        equalTapped = true
        guard let num1 = Double(number1 ?? "0"),
              let num2 = Double(numbers) else{
            return
        }
        switch operation{
        case "*":
            let result = num1 * num2
            number1 = "\(result)"
            resultLabel.text = "\(result)"
        case "/":
            let result = num1 / num2
            number1 = "\(result)"
            resultLabel.text = "\(result)"
        case "+":
            let result = num1 + num2
            number1 = "\(result)"
            resultLabel.text = "\(result)"
        case "-":
            let result = num1 - num2
            number1 = "\(result)"
            resultLabel.text = "\(result)"
        
            
        default:
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based on input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func operandButtonTapped(_ sender: UIButton){
        guard let op = sender.currentTitle  else {
            return
        }
        
        switch sender.currentTitle{
        case "*":
            operation = op
            calculatorLabel.text = op
            newOperation = true
            count+=1
        case "/":
            operation = op
            calculatorLabel.text = op
            newOperation = true
            count+=1
        case "-":
            operation = op
            calculatorLabel.text = op
            newOperation = true
            count+=1
        case "+":
            operation = op
            calculatorLabel.text = op
            newOperation = true
            count+=1
        default:
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based on input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    func add<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        firstNumber + secondNumber
    }
}

