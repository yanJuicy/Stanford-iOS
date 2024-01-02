//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by a on 2024/01/02.
//

import Foundation


class CalculatorBrain {
    
    private var accumlator = 0.0
    private var opertaions: [String: Operation] = [
        "π": .Constant(Double.pi),
        "e": .Constant(M_E),
        "√": .UnaryOperation(sqrt),
        "cos": .UnaryOperation(cos),
        "×": .BinaryOpertaion({ $0 * $1 }),
        "÷": .BinaryOpertaion({ $0 / $1 }),
        "+": .BinaryOpertaion({ $0 + $1 }),
        "−": .BinaryOpertaion({ $0 - $1 }),
        "=": .Equals
    ]
    private var pending: PendingBinaryOperationInfo?
    
    var result: Double {
        get {
            return accumlator
        }
    }
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOpertaion((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumlator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = opertaions[symbol] {
            switch operation {
            case .Constant(let value):
                accumlator = value
            case .UnaryOperation(let function):
                accumlator = function(accumlator)
            case .BinaryOpertaion(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumlator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumlator = pending!.binaryFunction(pending!.firstOperand, accumlator)
            pending = nil
        }
    }
    
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
}
