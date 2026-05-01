//
//  AddView.swift
//  iExpense
//
//  Created by Abdulkarim Mziya on 2026-04-27.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = "Add new Item"
    @State private var type: String = ""
    @State private var price: Double = 0.0
    
    let types = ["Business","Personal"]
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
            
                Picker("Expense Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                TextField("Price", value: $price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, price: price)
                    expenses.items.append(item)
                    
                    expenses.save()
                    
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
