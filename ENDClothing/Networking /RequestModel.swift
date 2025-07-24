//
//  RequestModel.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//

import Foundation

public struct RequestModel {
    let endpoints: EndPoints
    let requestTimeOut: Float?
    
    public init(endpoints: EndPoints,
                requestTimeOut: Float? = nil) {
        self.endpoints = endpoints
        self.requestTimeOut = requestTimeOut
    }
    
    func getUrlRequest() -> URLRequest? {
        guard let url = endpoints.getUrl() else {
            print("URL not found")
            return nil
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = endpoints.method.rawValue
        endpoints.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
}
