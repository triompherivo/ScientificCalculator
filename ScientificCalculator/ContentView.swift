//
//  ContentView.swift
//  ScientificCalculator
//
//  Created by Ramandalahy Triomphe on 16/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculatorView()
                .tabItem {
                    Image(systemName: "calculator")
                    Text("Calc")
                }
            
            CurrencyView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Currency")
                }
            
            // Add a Matrix tab when you create MatrixView
            MatrixView()
                .tabItem {
                     Image(systemName: "square.grid.3x3.fill")
                    Text("Matrix")
               }
        }
    }
}
