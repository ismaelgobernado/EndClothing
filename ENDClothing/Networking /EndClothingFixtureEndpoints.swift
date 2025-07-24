//
//  EndClothingFixtureEndpoints.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//

import Foundation

/// Alternate Endpoints to use during the review of the project

/// NOTE: token gets deprecated in a very short time
let github_token : String = "GHSAT0AAAAAADH2APMAVO5GK2YFB3CDYNIQ2ECBQTQ"

enum EndClothingFixtureEndpoints: EndPoints {
    
    case github_SortingData, github_invalidJson
    
    var baseURL: String {
        switch self {
        case .github_SortingData:
            return "raw.githubusercontent.com"
        case .github_invalidJson:
            return "raw.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
        case .github_SortingData:
            return "/ismaelgobernado/EndClothingBack/refs/heads/main/example.json"
        case .github_invalidJson:
            return "/ismaelgobernado/EndClothingBack/refs/heads/main/invalidJson.json"
        }
    }
    
    
    var parameter: [URLQueryItem] {
        switch self {
        case .github_SortingData:
            return [URLQueryItem(name: "token", value: github_token)]
        case .github_invalidJson:
            return [URLQueryItem(name: "token", value: github_token)]
        }
    }
    
    var headers: Headers {
        ["Accept":"text/json"]
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
