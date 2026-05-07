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
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            Image(systemName: "book")
                                .font(.system(size: 24))
                                .padding()
                                .background(.blue.opacity(0.75))
                                .clipShape(.rect(cornerRadius: 16))
                            VStack(alignment: .leading, spacing: 8) {
                                Text(book.title)
                                    .font(.title2.bold())
                                
                                Text(book.author)
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
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
            .navigationDestination(for: Book.self) { book in
                
                // Show Detail View
                DetailView(book: book)
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
