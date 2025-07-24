//
//  NetworkServiceTests.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import XCTest
import Combine
@testable import ENDClothing

final class NetworkServiceTests: XCTestCase {
    
    private static var cancellables : Set<AnyCancellable>!
    
    override class func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override class func tearDown() {
        cancellables.removeAll()
    }
    
    /// Integration test that uses httpbin.org to retrieve a 404 page and check that the networking layer is abble to capture and survive a serverError
    func testEndpointUnhappyPath() {
        let expectation = self.expectation(description: "The test should finish with a ServerError")
        
        let networkService = NetworkService()
        networkService.fetchItems(TestEndpoints.status404)
            .sink(
                receiveCompletion: {  completion in
                    if case let .failure(error) = completion {
                        XCTAssertEqual(error, NetworkError.serverError(error: "Server Error"))
                        expectation.fulfill()
                    }
                },
                receiveValue: { (productListing : ProductListing) in
                    expectation.fulfill()
                }).store(in: &NetworkServiceTests.cancellables)
        
        wait(for: [expectation], timeout:  10.0)
    }
    
    /// Integration test that uses a fake urll to trigger a networking error.
    func testEndpointBadURL() {
        
        let expectation = self.expectation(description: "The test should finish with a Bad URL Error")
        
        let networkService = NetworkService()
        networkService.fetchItems(TestEndpoints.nonExistentURL)
            .sink(
                receiveCompletion: {  completion in
                    if case let .failure(error) = completion {
                        XCTAssertEqual(error, NetworkError.badURL("Bad URL"))
                        expectation.fulfill()
                    }
                },
                receiveValue: { (productListing : ProductListing) in
                    expectation.fulfill()
                }).store(in: &NetworkServiceTests.cancellables)
        
        wait(for: [expectation], timeout:  10.0)
    }
    
    /// Integration test that compares data from a fixture with the provided endpoint.
    func testEndpointHappyPath() {
        
        let expectation = self.expectation(description: "The test should finish without exceptions")
        
        let expectedResponse = Bundle.main.decode(ProductListing.self, from: "Example.json")
        
        let networkService = NetworkService()
        networkService.fetchItems(EndClothingEndpoints.catalog)
            .sink(
                receiveCompletion: {  completion in
                    if case let .failure(error) = completion {
                        XCTFail("\(error)")
                        expectation.fulfill()
                        return
                    }
                },
                receiveValue: { (productListing : ProductListing) in
                    let expectedResponseNames = expectedResponse.products.compactMap{$0.name}
                    let filteredItems:[Product] = productListing.products.filter {expectedResponseNames.contains($0.name) }
                    
                    XCTAssertTrue(Product.areProductsEqual(expectedResponse.products, filteredItems), "The data from the endpoint and the fixture are not the same")
                    expectation.fulfill()
                }).store(in: &NetworkServiceTests.cancellables)
        
        wait(for: [expectation], timeout:  10.0)
    }
    
}
