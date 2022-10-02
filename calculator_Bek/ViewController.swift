import UIKit

class ViewController: UIViewController {
    
    var didOperandButtonTapped = false
    var operand: String = ""
    var result: Double = .zero {
        didSet {
            displayLabel.text = "\(result)"
        }
    }
    
    var numbers = [Double]() {
        didSet {
            print(numbers)
        }
    }
    
    var displayValue: String? {
        get {
            displayLabel.text
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if displayLabel.text == "0" {
                displayLabel.text! = newValue
            } else {
                displayLabel.text! += newValue
            }
        }
    }
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didTapDigitButton(_ sender: UIButton) {
        if didOperandButtonTapped {
            displayLabel.text = "0"
            didOperandButtonTapped = false
        }
        guard let currentTitle = sender.currentTitle else {
            return
        }
        displayValue = currentTitle
    }
    
    @IBAction private func didTapOperandButton(_ sender: UIButton) {
        didOperandButtonTapped = true
        
        guard let currentTitle = sender.currentTitle else {
            return
        }
        
        switch currentTitle {
        case "*":
            operand = currentTitle
            doCalculations(numbers: numbers, operand: operand)
        case "/":
            operand = currentTitle
            doCalculations(numbers: numbers, operand: operand)
        case "-":
            operand = currentTitle
            doCalculations(numbers: numbers, operand: operand)
        case "+":
            operand = currentTitle
            doCalculations(numbers: numbers, operand: operand)
        case "=":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            numbers.append(displayValueInDouble)
            
            if numbers.count > 1 {
                
                guard let secondNumber = numbers.popLast(),
                      let firstNumber = numbers.popLast() else {
                    return
                }
                
                
                let result = equalButtonTapped(number1: firstNumber, number2: secondNumber, operand: operand)
                self.result = result
            }
        default:
            break
        }
    }
    
    @IBAction private func didSquareButtonTapped(_ sender: UIButton){
        guard let number = Double(displayLabel.text ?? "0") else {
            return
        }
        let result = mult(firstNumber: number, secondNumber: number)
        self.result = result
    }
    
    @IBAction private func didSquareRootButtonTapped(_ sender: UIButton){
        guard let number = Double(displayLabel.text ?? "0") else {
            return
        }
        let result = sqrt(number)
        self.result = result
    }
    
    @IBAction private func didPowerMinusOneTapped(_ sender: UIButton){
        guard let number = Double(displayLabel.text ?? "0") else {
            return
        }
        let result = 1 / number
        self.result = result
    }
    
    @IBAction private func didTapClearButton(_ sender: UIButton) {
        displayLabel.text = ""
    }
    
    @IBAction private func didDeleteButtonTapped(_ sender: UIButton){
        guard var number = displayLabel.text else {
            return
        }
        number.removeLast()
        displayLabel.text = number
    }
    
    func equalButtonTapped(number1: Double, number2: Double, operand: String) -> Double{
        
        switch operand{
        case "*":
            return number1 * number2
        case "/":
            return number1 / number2
        case "+":
            return number1 + number2
        case "-":
            return number1 - number2
        default:
            return .zero
        }
    }
    
    func doCalculations(numbers: [Double], operand: String) -> Void{
        if numbers.count > 1 {
            
            guard let firstNumber = self.numbers.popLast(),
                  let secondNumber = self.numbers.popLast() else {
                return
            }
            switch operand {
            case "+":
                let result = sum(firstNumber: firstNumber,
                                 secondNumber: secondNumber)
                self.result = result
            case "-":
                let result = subt(firstNumber: firstNumber,
                                  secondNumber: secondNumber)
                self.result = result
            case "*":
                let result = mult(firstNumber: firstNumber,
                                  secondNumber: secondNumber)
                self.result = result
            case "/":
                let result = div(firstNumber: firstNumber,
                                 secondNumber: secondNumber)
                self.result = result
            default:
                print("Error")
            }
            
        } else {
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            self.numbers.append(displayValueInDouble)
        }
    }
    
    func sum<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        firstNumber + secondNumber
    }
    func subt(firstNumber: Double, secondNumber: Double) -> Double {
        firstNumber - secondNumber
    }
    func mult<T: Numeric>(firstNumber: T, secondNumber: T) -> T {
        firstNumber * secondNumber
    }
    func div(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber / secondNumber
    }
}

