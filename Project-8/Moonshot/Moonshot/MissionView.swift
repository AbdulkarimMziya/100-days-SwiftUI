//
//  MissionView.swift
//  Moonshot
//
//  Created by Abdulkarim Mziya on 2026-04-28.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(.example)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width,axis in
                            width * 0.6
                        }
                        .padding(.top)
                    
                    VStack(alignment:.leading, spacing: 8) {
                        Text("Mission Statement")
                            .font(.title).bold()
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.black.opacity(0.9))
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
