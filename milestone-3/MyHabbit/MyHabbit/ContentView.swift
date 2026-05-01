//
//  ContentView.swift
//  MyHabbit
//
//  Created by Abdulkarim Mziya on 2026-04-30.
//

import SwiftUI

struct Activity: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String?
    let completionCount: Int
    let type: String
}

@Observable
class Activities {
    var items = [Activity]()
}

struct ContentView: View {
    @State private var activities = Activities()
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    
                    NavigationLink(value: activity) {
                        // Desisgn Row label
                        Text(activity.name)
                    }
                    
                }
            }
            .navigationTitle("Activities")
            .navigationDestination(for: Activity.self) { selection in
                Text("Details: \(selection.name)")
            }
                
            
        }
        
    }
}

#Preview {
    ContentView()
}
