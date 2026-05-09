//
//  User.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-08.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    var isActive: Bool
    let name: String
    let age: Int
    let company: String
    var email: String
    var address: String     
    var about: String
    var registered: String  // Date registered
    var friends: [Friend]
    
    struct Friend: Codable, Identifiable {
        let id: String
        let name: String
    }
    
    var activeStatus: String {
        isActive ? "Active" : "Offline"
    }
    
    var formattedDate: String {
        let dateString = registered
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            return date.formatted(date: .long, time: .omitted)
        }
        return "Unknown date"
    }
}
