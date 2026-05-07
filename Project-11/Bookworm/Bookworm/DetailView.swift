//
//  DetailView.swift
//  Bookworm
//
//  Created by Abdulkarim Mziya on 2026-05-06.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .font(.system(size: 16))
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)

            Text(book.review)
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        
        let exampleBook = Book(title: "Twitts", author: "Roald Dahl", genre: "Mystery", review: "This is a beautiful book for kids!!", rating: 2)
        
        return DetailView(book: exampleBook)
            .modelContainer(container)
    } catch {
        return Text("Faild to obtain query of Book")
    }
    
}
