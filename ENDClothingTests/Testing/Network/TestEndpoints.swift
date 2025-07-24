//
//  TestEndpoints.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import Foundation
@testable import ENDClothing

enum TestEndpoints: EndPoints {
    
    case status404
    case nonExistentURL
    
    var baseURL: String {
        switch self {
        case .status404:
            return "httpbin.org"
        case .nonExistentURL:
            return "no"
        }
    }
    
    var path: String {
        switch self {
        case .status404:
            return "/status/404"
        case .nonExistentURL:
            return "no"
        }
    }
    
    var parameter: [URLQueryItem] {
        []
    }
    
    var headers: Headers {
        [:]
    }
    
    var method: HTTPMethod {
        switch self {
        case .status404, .nonExistentURL:
            return .get
        }
    }
}
