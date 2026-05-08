//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Abdulkarim Mziya on 2026-05-05.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
