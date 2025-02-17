//
//  Matrix.swift
//  ScientificCalculator
//
//  Created by Ramandalahy Triomphe on 16/02/2025.
//

import Foundation

struct Matrix {
    let rows: Int
    let cols: Int
    var grid: [Double]

    // Initialize with given dimensions; optionally fill with a repeated value (default is 0.0)
    init(rows: Int, cols: Int, repeatedValue: Double = 0.0) {
        self.rows = rows
        self.cols = cols
        self.grid = Array(repeating: repeatedValue, count: rows * cols)
    }
    
    // Convenient initializer from a 2D array
    init(_ array: [[Double]]) {
        self.rows = array.count
        self.cols = array.first?.count ?? 0
        self.grid = array.flatMap { $0 }
    }
    
    // Subscript to get/set matrix elements
    subscript(row: Int, col: Int) -> Double {
        get {
            precondition(row < rows && col < cols, "Index out of range")
            return grid[(row * cols) + col]
        }
        set {
            precondition(row < rows && col < cols, "Index out of range")
            grid[(row * cols) + col] = newValue
        }
    }
    
    // Display the matrix nicely
    func description() -> String {
        var result = ""
        for i in 0..<rows {
            let rowElements = (0..<cols).map { String(format: "%g", self[i, $0]) }
            result += "[ " + rowElements.joined(separator: "\t") + " ]\n"
        }
        return result
    }
}

// MARK: - Matrix Operations

extension Matrix {
    // Matrix Addition
    static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows && lhs.cols == rhs.cols, "Matrices must have the same dimensions")
        var result = Matrix(rows: lhs.rows, cols: lhs.cols)
        for i in 0..<lhs.rows {
            for j in 0..<lhs.cols {
                result[i, j] = lhs[i, j] + rhs[i, j]
            }
        }
        return result
    }
    
    // Matrix Subtraction
    static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.rows == rhs.rows && lhs.cols == rhs.cols, "Matrices must have the same dimensions")
        var result = Matrix(rows: lhs.rows, cols: lhs.cols)
        for i in 0..<lhs.rows {
            for j in 0..<lhs.cols {
                result[i, j] = lhs[i, j] - rhs[i, j]
            }
        }
        return result
    }
    
    // Matrix Multiplication
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.cols == rhs.rows, "Incompatible dimensions for multiplication")
        var result = Matrix(rows: lhs.rows, cols: rhs.cols)
        for i in 0..<lhs.rows {
            for j in 0..<rhs.cols {
                var sum = 0.0
                for k in 0..<lhs.cols {
                    sum += lhs[i, k] * rhs[k, j]
                }
                result[i, j] = sum
            }
        }
        return result
    }
    
    // Scalar multiplication
    static func *(lhs: Matrix, rhs: Double) -> Matrix {
        var result = Matrix(rows: lhs.rows, cols: lhs.cols)
        for i in 0..<lhs.rows {
            for j in 0..<lhs.cols {
                result[i, j] = lhs[i, j] * rhs
            }
        }
        return result
    }
    
    static func *(lhs: Double, rhs: Matrix) -> Matrix {
        return rhs * lhs
    }
}

