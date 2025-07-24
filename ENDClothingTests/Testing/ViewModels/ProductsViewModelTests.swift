//
//  ProductsViewModelTests.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import XCTest
import Combine
@testable import ENDClothing

@MainActor
final class ProductsViewModelTests: XCTestCase {
    
    var viewModel: ProductsViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    @MainActor func testFetchDataSuccess() async {
        let expectation = self.expectation(description: "The test should finish without exceptions")
        let mockService = MockNetworkService() // No failure
        
        viewModel = ProductsViewModel(networkService: mockService)
        
        viewModel.networkService.fetchItems(EndClothingEndpoints.catalog).sink { completion in
            if case let .failure(error) = completion {
                XCTFail("\(error)")
                expectation.fulfill()
                return
            }
        } receiveValue: { (productListing: ProductListing) in
            XCTAssertEqual(productListing.title, "Sample Product Listing", "Title should match expected value.")
            XCTAssertEqual(productListing.productCount, 2, "Product count should be 2.")
            XCTAssertEqual(productListing.products.count, 2, "There should be 2 products in the listing.")
            XCTAssertEqual(productListing.products.first?.name, "Test Product 1", "The first product's name should match.")
            
        }
        expectation.fulfill()
        
        wait(for: [expectation], timeout:  10.0)
    }
    
    func testFetchDataFailure() async {
        let mockService = MockNetworkService(shouldFail: true)
        viewModel = ProductsViewModel(networkService: mockService)
        
        await viewModel.fetchData()
        
        XCTAssertEqual(viewModel.title, "", "Title should be empty on fetch failure.")
        XCTAssertEqual(viewModel.productCount, 0, "Product count should be 0 on fetch failure.")
        XCTAssertEqual(viewModel.products.count, 0, "There should be no products on fetch failure.")
    }
    
    func testSortingFunctionality() {
        let product1 = Product(id: "0", name: "Test Product 1", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product1")!)
        let product2 = Product(id: "1", name: "Test Product 2", price: "£20.99", image: URL(string: "https://placehold.co/250x250?text=Product2")!)
        viewModel = ProductsViewModel(products: [product2, product1]) // Start with unsorted products
        viewModel.selectedSorting = .low // Trigger sorting
        
        XCTAssertEqual(viewModel.products[0], product1, "Products should be sorted by low price.")
        XCTAssertEqual(viewModel.products[1], product2, "Products should be sorted by low price.")
    }
    
}
