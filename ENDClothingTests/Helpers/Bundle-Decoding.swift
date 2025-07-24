//
//  Bundle-Decoding.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import Foundation


extension Bundle {
    /// This extension can not be used in a production enviroment
    /// WARNING:
    /// - fatalError is not an exception so it can not be captured with a do catch
    func decode<T:Decodable>(_ type: T.Type, from file:String)-> T  {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
