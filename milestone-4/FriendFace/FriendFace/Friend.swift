//
//  Friend.swift
//  FriendFace
//
//  Created by Abdulkarim Mziya on 2026-05-10.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Identifiable {
    var id: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id     = try container.decode(String.self, forKey: .id)
        self.name   = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
