//
//  ContentView.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \User.name) var users: [User]
 
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
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
                            Text(user.activeStatus)
                                .font(.caption)
                            Circle()
                                .fill(user.isActive ? .green : .red)
                                .frame(width: 12, height: 12)
                                .overlay {
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                        }
                    }
                }
            }
            .navigationTitle("Friends")
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
                // 4. Save user in SwiftData
                for user in decodedResponse {
                    modelContext.insert(user)
                }
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
