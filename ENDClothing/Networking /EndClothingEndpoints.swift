//
//  EndClothingEndpoints.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//


import Foundation

enum EndClothingEndpoints: EndPoints {
    
    case catalog
    
    var baseURL: String {
        switch self {
        case .catalog:
            return "www.endclothing.com"
        }
    }
    
    var path: String {
        switch self {
        case .catalog:
            return "/media/catalog/example.json"
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        case .catalog:
            return []
        }
    }
    
    var headers: Headers {
        [:]
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
