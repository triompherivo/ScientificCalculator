//
//  CalculatorView.swift
//  ScientificCalculator
//
//  Created by Ramandalahy Triomphe on 16/02/2025.
//

import SwiftUI
import Expression



struct CalculatorView: View {
    @State private var display = "0"
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .divide, .multiply, .delete],
        [.seven, .eight, .nine, .subtract],
        [.four, .five, .six, .add],
        [.one, .two, .three, .equals],
        [.zero, .decimal, .log, .exp],
        [.sin, .cos, .matrix, .currency]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            // Display Area
            HStack {
                Spacer()
                Text(display)
                    .font(.largeTitle)
                    .padding()
            }
            // Buttons Grid
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button.title)
                                .font(.title)
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // Sample logic for sizing
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 5*12) / 2
        }
        return (UIScreen.main.bounds.width - 5*12) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5*12) / 4
    }
    
    func evaluateExpression(_ input: String) -> String {
        let validInput = input
                .replacingOccurrences(of: "×", with: "*")
                .replacingOccurrences(of: "÷", with: "/")
        let expression = Expression(validInput)
        do {
            let result = try expression.evaluate()
            return String(result)
        } catch {
            return "Error"
        }
    }
    
    // Handle button actions
    func buttonTapped(_ button: CalculatorButton) {
        // Here you'll add the logic to update the display and perform calculations.
        // For now, we'll just append the button title for numeric buttons.
        switch button {
        case .clear:
            display = "0"
        case .delete:
            display = String(display.dropLast())
            if display.isEmpty { display = "0" }
        case .equals:
            display = evaluateExpression(display)
            break
        case .sin:
            if let value = Double(display) {
                display = String(sin(value))
            }
        case .cos:
            if let value = Double(display) {
                display = String(cos(value))
            }
        case .log, .exp, .matrix, .currency:
            // Navigate or perform the scientific function
            break
        default:
            if display == "0" {
                display = button.title
            } else {
                display += button.title
            }
        }
    }
}

enum CalculatorButton: Hashable {
    case clear, delete, divide, multiply, subtract, add, equals
    case decimal, log, exp, sin, cos, matrix, currency
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var title: String {
        switch self {
        case .clear: return "AC"
        case .delete: return "⌫"
        case .divide: return "÷"
        case .multiply: return "×"
        case .subtract: return "−"
        case .add: return "+"
        case .equals: return "="
        case .decimal: return "."
        case .log: return "log"
        case .exp: return "exp"
        case .sin: return "sin"
        case .cos: return "cos"
        case .matrix: return "Mat"
        case .currency: return "$"
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        }
    }
}
