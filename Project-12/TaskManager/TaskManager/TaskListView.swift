//
//  TaskListView.swift
//  TaskManager
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    
    @Query var tasks: [Task]
    
    init(filterCategory: String ,filterCompleted: Bool?, sortOrder: [SortDescriptor<Task>] ) {
        
        if let filterCompleted {
                
            _tasks = Query(
                filter: #Predicate<Task> { task in
                    (filterCategory == "" || task.category == filterCategory) &&
                    task.isCompleted == filterCompleted
                },
                sort: sortOrder
            )
            
        } else {
            
            _tasks = Query(
                filter: #Predicate<Task> { task in
                    filterCategory == "" || task.category == filterCategory
                },
                sort: sortOrder
            )
        }
    }
    
    var body: some View {
        List(tasks) { task in
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted)
                HStack {
                    Text(task.category)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(.blue.opacity(0.15))
                        .clipShape(.capsule)
                    Spacer()
                    Text("Priority: \(task.priority)")
                        .font(.caption)
                        .foregroundStyle(priorityColor(task.priority))
                    Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    func priorityColor(_ priority: Int) -> Color {
        switch priority {
        case 3: return .red
        case 2: return .orange
        default: return .green
        }
    }
}

#Preview {
    TaskListView(filterCategory: "Personal", filterCompleted: true, sortOrder: [
        SortDescriptor(\Task.dueDate)
    ])
}
