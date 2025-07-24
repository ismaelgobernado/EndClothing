//
//  NetworkService.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//

import Combine

class NetworkService {
    
    private var networkRequest: Requestable
    
    init(networkRequest: Requestable = NetworkRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func fetchItems<T: Codable>(_ endpoint: EndPoints) -> AnyPublisher<T, NetworkError> {
        let requestModel = RequestModel(endpoints: endpoint, requestTimeOut: 30)
        return networkRequest.request(requestModel)
    }
}
