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
    
    @State private var showingAddBookView = false
    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("Books")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddBookView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddBookView) {
                    
                    // SHow AddBook View
                    AddBookView()
                }
        }
    }
}

#Preview {
    ContentView()
}
