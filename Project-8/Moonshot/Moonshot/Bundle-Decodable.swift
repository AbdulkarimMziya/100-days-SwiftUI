//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Abdulkarim Mziya on 2026-04-28.
//

import Foundation

extension Bundle  {
    func decode<T: Codable>(_ file: String) -> T {
        // 1. locate the file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file path: \(file)")
        }
        
        // 2. load the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file: \(file) from bundle.")
        }
        
        // 3. decode the data
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode file: \(file)")
        }
    }
}
