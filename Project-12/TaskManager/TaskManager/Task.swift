//
//  Task.swift
//  TaskManager
//
//  Created by Abdulkarim Mziya on 2026-05-07.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    var priority: Int   // 1 = Low, 2 = Medium, 3 = High
    var isCompleted: Bool
    var DueDate: Date
    var category: String    // "Work", "Personal"
    
    init(title: String, priority: Int, isCompleted: Bool, DueDate: Date, category: String) {
        self.title = title
        self.priority = priority
        self.isCompleted = isCompleted
        self.DueDate = DueDate
        self.category = category
    }
}
