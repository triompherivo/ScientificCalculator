//
//  MatrixView.swift
//  ScientificCalculator
//
//  Created by Ramandalahy Triomphe on 16/02/2025.
//

import SwiftUI

struct MatrixView: View {
    // For demonstration, hard-coded matrices
    let matrixA = Matrix([[1, 2, 3],
                          [4, 5, 6]])
    
    let matrixB = Matrix([[7, 8],
                          [9, 10],
                          [11, 12]])
    
    @State private var resultDescription = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Matrix Multiplication")
                .font(.title)
            
            Button("Multiply A × B") {
                let product = matrixA * matrixB
                resultDescription = product.description()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            ScrollView {
                Text(resultDescription)
                    .font(.system(.body, design: .monospaced))
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

