//
//  ProductListing.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

struct ProductListing : Codable {
    let products : [Product]
    let title : String
    let productCount: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case title = "title"
        case productCount = "product_count"
    }
}
