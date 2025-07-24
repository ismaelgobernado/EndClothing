//
//  ProductTest.swift
//  ENDClothingTests
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import XCTest
@testable import ENDClothing

final class ProductTest: XCTestCase {
    
    /// Tests if a Product can be initialized correctly and checks the properties.
    func testProductInitialization() {
        let product = Product(id: "1", name: "Test Product", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        
        XCTAssertEqual(product.name, "Test Product", "Product name should match.")
        XCTAssertEqual(product.price, Decimal(string: "10.99"), "Product price should match.")
        XCTAssertEqual(product.image, URL(string: "https://placehold.co/250x250?text=Product"), "Product image URL should match.")
        XCTAssertNotNil(product.id, "Product ID should not be nil.")
    }
    
    /// Creates a JSON representation of a Product and checks if decoding works as expected.
    func testProductDecoding() {
        let json = """
           {
               "name": "Test Product",
               "price": "£10.99",
               "image": "https://placehold.co/250x250?text=Product"
           }
           """
        let jsonData = json.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let product = try decoder.decode(Product.self, from: jsonData)
            XCTAssertEqual(product.name, "Test Product", "Decoded product name should match.")
            XCTAssertEqual(product.price, Decimal(string: "10.99"), "Decoded product price should match.")
            XCTAssertEqual(product.image, URL(string: "https://placehold.co/250x250?text=Product"), "Decoded product image URL should match.")
        } catch {
            XCTFail("Decoding failed with error: \(error).")
        }
    }
    
    /// Checks if two products with different IDs but identical properties are considered equal.
    func testEqualityExcludingID() {
        let product1 = Product(id: "1", name: "Test Product", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product2 = Product(id: "2", name: "Test Product", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        
        XCTAssertTrue(product1.isEqualExcludingID(to: product2), "Products should be equal excluding ID.")
    }
    
    func testArrayEquality() {
        let product1 = Product(id: "1", name: "Test Product 1", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product1")!)
        let product2 = Product(id: "2", name: "Test Product 2", price: "£20.99", image: URL(string: "https://placehold.co/250x250?text=Product2")!)
        
        let array1 = [product1, product2]
        let array2 = [product1, product2]
        let array3 = [product1]
        
        XCTAssertTrue(Product.areProductsEqual(array1, array2), "Arrays should be equal.")
        XCTAssertFalse(Product.areProductsEqual(array1, array3), "Arrays should not be equal.")
    }
    
}
