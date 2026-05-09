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
        NavigationStack {
            List {
                ForEach(users) { user in
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 32))
                            .padding(8)
                            .background(.black.opacity(0.16))
                            .clipShape(.circle)
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 2)
                            }
                        Text(user.name)
                        
                        Spacer()
                        Text("Status: \(user.activeStatus)")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Users")
        }
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
