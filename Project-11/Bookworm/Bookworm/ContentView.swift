//
//  ContentView.swift
//  Bookworm
//
//  Created by Abdulkarim Mziya on 2026-05-05.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    var body: some View {
        
    }
}

#Preview {
    ContentView()
}
