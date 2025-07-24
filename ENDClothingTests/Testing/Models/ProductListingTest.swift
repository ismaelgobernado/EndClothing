//
//  ProductListingTest.swift
//  ENDClothingTests
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import XCTest
@testable import ENDClothing

final class ProductListingTest: XCTestCase {
    
    func testProductListingDecoding() {
        let json = """
            {
                "products": [
                    {
                        "id": "0",
                        "name": "Test Product 1",
                        "price": "£10.99",
                        "image": "https://placehold.co/250x250?text=Product1"
                    },
                    {
                        "id": "1",
                        "name": "Test Product 2",
                        "price": "£20.99",
                        "image": "https://placehold.co/250x250?text=Product2"
                    }
                ],
                "title": "Sample Product Listing",
                "product_count": 2
            }
            """
        let jsonData = json.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let productListing = try decoder.decode(ProductListing.self, from: jsonData)
            XCTAssertEqual(productListing.title, "Sample Product Listing", "The title should match.")
            XCTAssertEqual(productListing.productCount, 2, "Product count should be 2.")
            XCTAssertEqual(productListing.products.count, 2, "There should be 2 products in the listing.")
            XCTAssertEqual(productListing.products[0].name, "Test Product 1", "The first product's name should match.")
            XCTAssertEqual(productListing.products[1].name, "Test Product 2", "The second product's name should match.")
        } catch {
            XCTFail("Decoding failed with error: \(error).")
        }
    }
    
}
