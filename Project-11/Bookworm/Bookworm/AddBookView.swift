//
//  AddBookView.swift
//  Bookworm
//
//  Created by Abdulkarim Mziya on 2026-05-06.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Book Author", text: $author)
                    
                    Picker("Select Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("Write a review") {
                    TextField("", text: $review, axis: .vertical)
                    
                    // Rating View
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
