//
//  ContentView.swift
//  Moonshot
//
//  Created by Abdulkarim Mziya on 2026-04-27.
//

import SwiftUI

struct ContentView: View {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail: \(mission.displayName)")
                        } label: {
                            VStack {
                                Image(.example)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThickMaterial)
                            }
                            .clipShape(.rect(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.secondary, lineWidth: 4)
                                    
                            )
                        }
                        
                    
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.black.opacity(0.9))
            .preferredColorScheme(.dark)
        
        }
    }
}

#Preview {
    ContentView()
}
