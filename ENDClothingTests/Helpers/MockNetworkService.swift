//
//  MockNetworkService.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import Combine
import Foundation
@testable import ENDClothing

class MockNetworkService: NetworkService {
    
    var shouldFail: Bool = false
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    private var cancellables = Set<AnyCancellable>()
    
    func fetchItems(_ endpoint: TestEndpoints) -> AnyPublisher<ProductListing, NetworkError> {
        return Future { promise in
            // Simulate network delay
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                if self.shouldFail {
                    promise(.failure(NetworkError.failedRequest))
                } else {
                    // Create mock products
                    let mockProducts = [
                        Product(id: "0", name: "Test Product 1", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product1")!),
                        Product(id: "1", name: "Test Product 2", price: "£20.99", image: URL(string: "https://placehold.co/250x250?text=Product2")!)
                    ]
                    // Create a mock product listing
                    let mockListing = ProductListing(products: mockProducts, title: "Sample Product Listing", productCount: 2)
                    promise(.success(mockListing))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
