//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
