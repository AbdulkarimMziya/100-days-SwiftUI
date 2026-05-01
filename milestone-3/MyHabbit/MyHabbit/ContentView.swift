//
//  ContentView.swift
//  MyHabbit
//
//  Created by Abdulkarim Mziya on 2026-04-30.
//

import SwiftUI

struct Activity: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let description: String?
    var completionCount: Int
    let type: String
}

@Observable
class Activities {
    var items = [Activity]()
}

struct ContentView: View {
    @State private var activities = Activities()

    @State private var showAddActivity = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    
                    NavigationLink(value: activity) {
                        // Desisgn Row label
                        Text(activity.name)
                    }
                }
                .onDelete(perform: deleteActivity)
            }
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddActivity.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Activity.self) { selection in
                Text("Details: \(selection.name)")
            }
            .sheet(isPresented: $showAddActivity ) {
                // Show AddActivity View
                AddActivity(activities: activities)
            }
                
            
        }
        
    }
    
    func deleteActivity(offSet: IndexSet) {
        activities.items.remove(atOffsets: offSet)
    }
}

#Preview {
    ContentView()
}
