//
//  ContentView.swift
//  iExpense
//
//  Created by Abdulkarim Mziya on 2026-04-27.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let price: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
    
    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                print(items.count)
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.price, format: .currency(code: "USD"))
                            .foregroundStyle(item.price < 10 ? .green : item.price < 100 ? .orange : .red)
                    }
                    
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            
        }
    }
        
    func removeItem(offSet: IndexSet) {
        expenses.items.remove(atOffsets: offSet)
    }
}

#Preview {
    ContentView()
}
