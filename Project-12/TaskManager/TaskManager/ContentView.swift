//
//  ContentView.swift
//  TaskManager
//
//  Created by Abdulkarim Mziya on 2026-05-07.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    // Filter States
    @State private var showCompleted: Bool? = nil
    @State private var showCategory = ""
    
    // Sort Order
    @State private var sortOrder: [SortDescriptor<Task>] = [
        SortDescriptor(\Task.dueDate)
    ]
        
    
    let categories = ["","Personal", "Work"]
    
    var body: some View {
        NavigationStack {
            // TaskListView - pass Filter & sort states
            TaskListView(filterCategory: showCategory, filterCompleted: showCompleted, sortOrder: sortOrder
            )
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Task", systemImage: "plus") {
                        addSampleTasks()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $sortOrder) {
                            Text("Due Date")
                                .tag([SortDescriptor(\Task.dueDate)])
                            Text("Priority (High first)")
                                .tag([SortDescriptor(\Task.priority, order: .reverse)])
                            Text("Title")
                                .tag([SortDescriptor(\Task.title)])
                        }
                    }
                }
            }
        }
    }
    
    func addSampleTasks() {
        let samples: [(String, Int, Bool, Double, String)] = [
            ("Write project report", 3, false, 86400 * 2, "Work"),
            ("Buy groceries", 1, false, 86400 * 1, "Personal"),
            ("Call mom", 2, true, -86400 * 1, "Personal"),
            ("Fix login bug", 3, true, -86400 * 3, "Work"),
            ("Read book", 1, false, 86400 * 5, "Personal"),
            ("Plan team meeting", 2, false, 86400 * 1, "Work"),
            ("Get birthday gift", 2, false, 86400 * 3, "Personal"),
        ]
        
        for (title,priority,completed,dateOffset,category) in samples {
            let sample = Task(title: title, priority: priority, isCompleted: completed, dueDate: Date.now.addingTimeInterval(dateOffset), category: category)
            
            modelContext.insert(sample)
        }
    }
}

#Preview {
    ContentView()
}
