//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Henrique on 27/10/17.
//  Copyright © 2017 MobTime. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    private var acumulator: Double
    private var pendingOperation: ((Double, Double) -> Double)?
    
    init() {
        self.acumulator = 0
        self.pendingOperation = nil
    }
    
    public var result: Double? {
        get {
            return acumulator
        }
    }
    
    private enum Operation {
        case basic((Double, Double) -> Double)
        case complex((Double, Double) -> Double)
        case equals
    }
    
    private let operations: Dictionary<String,Operation> = [
        "+": Operation.basic({(op1, op2) in return op1 + op2}),
        "-": Operation.basic({(op1, op2) in return op1 - op2}),
        "x": Operation.complex({(op1, op2) in return op1 * op2}),
        "÷": Operation.complex({(op1, op2) in return op1 / op2}),
        "=": Operation.equals
    ]
    
    public mutating func performOperation(_ symbol: String,_ operand: Double) {
        if let op = operations[symbol] {
            switch op {
                case .basic(let f):
                    acumulator = f(operand, acumulator)
                    pendingOperation = f
                case .complex(let f):
                    if(acumulator == 0) {
                        acumulator = 1
                    }
                    acumulator = f(operand, acumulator)
                    pendingOperation = f
                case .equals:
                    acumulator = pendingOperation!(acumulator, operand)
            }
        }
    }
    
    public mutating func clear() {
        acumulator = 0
        pendingOperation = nil
    }
}

