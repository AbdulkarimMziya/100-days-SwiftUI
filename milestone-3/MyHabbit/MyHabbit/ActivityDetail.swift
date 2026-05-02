//
//  ActivityDetail.swift
//  MyHabbit
//
//  Created by Abdulkarim Mziya on 2026-05-01.
//

import SwiftUI

struct ActivityDetail: View {
    
    var activities: Activities
    var selection: Activity
    
    var count: Int {
        activities.items.first(where: { $0.id == selection.id })?.completionCount ?? 0
    }

    
    var body: some View {
            VStack(spacing: 0) {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .padding(24)
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.25
                        }
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 4)
                        }
                }
                .frame(maxWidth: .infinity)
                .containerRelativeFrame(.vertical) { size, axis in
                        size * 0.20 // Sets height to exactly 20% of the screen
                }
                .background(.pink.opacity(0.7))
                
                VStack {
                    Text(selection.name)
                        .font(.system(size: 32, weight: .bold))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Description:")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                        
                        Text(selection.description ?? "No Description")
                            .font(.title2)
                            .fontWeight(.semibold)
                            
                            
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .top])
                    
                    HStack(spacing: 24) {
                        Button {
                            if let index = activities.items.firstIndex(where: { $0.id == selection.id }) {
                                var thisActivity = activities.items[index]
                                
                                if thisActivity.completionCount > 0 {
                                    thisActivity.completionCount -= 1
                                }
                
                                activities.items[index] = thisActivity
                            }
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 20, weight: .bold))
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                }
                        }
                        
                        Text("\(count)")
                        
                        Button {
                            if let index = activities.items.firstIndex(where: { $0.id == selection.id }) {
                                var thisActivity = activities.items[index]
                                
                                thisActivity.completionCount += 1
                                
                                activities.items[index] = thisActivity
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .bold))
                                .frame(width: 44, height: 44)
                                .clipShape(.circle)
                                .overlay {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                }
                        }
                    }
                    .padding(.top, 100)
                    
                }
                .padding(.top)
                    
                
                Spacer()
            }
            
        }
}

#Preview {
    let newActivity = Activity(
        name: "name",
        description: "description dsfsd  sfs fsd fsd f sdfdsf sdfsdf dsfsfsdf",
        completionCount: 3,
        type: "type"
    )
    ActivityDetail(activities: Activities(), selection: newActivity)
}
