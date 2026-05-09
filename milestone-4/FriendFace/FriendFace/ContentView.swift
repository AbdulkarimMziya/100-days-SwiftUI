//
//  ContentView.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if !users.isEmpty {
                    Text("First Friend Count: \(users[0].friends.count)")
            } else {
                    Text("Loading users...")
            }
        }
        .padding()
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard users.isEmpty else { return } // Prevent duplicating data
        
        // 1. Creating the URL
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        
        do {
            // 2. Fetching the data for that URL.
            let (data,_) = try await URLSession.shared.data(from: url)
            
            // 3. Decoding the result of that data
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data){
                users = decodedResponse
            } else {
                print("Failed to decode data")
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

#Preview {
    ContentView()
}
