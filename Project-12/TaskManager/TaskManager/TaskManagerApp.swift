//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Abdulkarim Mziya on 2026-05-07.
//

import SwiftData
import SwiftUI

@main
struct TaskManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
