//
//  ContentView.swift
//  WeSplit
//
//  Created by Abdulkarim Mziya on 2026-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIdFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) + 2
        let tipValue = (Double(tipPercentage) / 100) * Double(checkAmount)
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / peopleCount
    }
    
    var grandTotal: Double {
        let tipValue = (Double(tipPercentage) / 100) * Double(checkAmount)
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        
        
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "CAD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIdFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("Tip %") {
                    Picker("Tip Percentage:", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section("Total per Person") {
                    Text(totalPerPerson,
                        format: .currency(code: Locale.current.currency?.identifier ?? "CAD")
                    )
                }
                
                Section("Grand Total") {
                    Text(grandTotal,
                         format: .currency(code: Locale.current.currency?.identifier ?? "CAD")
                    )
                }
            }
            .navigationTitle("WeSpilt")
            .toolbar {
                if amountIdFocused {
                    Button("Done") {
                        amountIdFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
