//
//  Mission.swift
//  Moonshot
//
//  Created by Abdulkarim Mziya on 2026-04-28.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
