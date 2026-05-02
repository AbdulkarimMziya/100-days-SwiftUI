//
//  AddActivity.swift
//  MyHabbit
//
//  Created by Abdulkarim Mziya on 2026-04-30.
//

import SwiftUI

struct AddActivity: View {
    /* Propperties */
    var activities: Activities
    
    /* State variables */
    @State private var name = ""
    @State private var description = ""
    @State private var completionCount = 0
    @State private var type = ""
    
    @Environment(\.dismiss) private var dissmiss
    
    let activityType = ["General", "Health", "Education", "Leisure"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    
                    Picker("Activity Type", selection: $type){
                        ForEach(activityType, id: \.self) { activityType in
                            Text(activityType)
                        }
                    }
                }
                
                Section("Activity Completion Counter"){
                    Picker("Activity Completion Counter", selection: $completionCount) {
                        ForEach(0..<1000) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    
                }
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Add") {
                    let newActivity = Activity(
                        name: name,
                        description: description,
                        completionCount: completionCount,
                        type: type
                    )
                    
                    activities.items.append(newActivity)
                    
                    dissmiss()
                }
            }
        }
    }
}

#Preview {
    AddActivity(activities: Activities())
}
