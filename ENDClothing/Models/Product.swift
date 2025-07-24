//
//  Product.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import Foundation

struct Product: Identifiable, Codable, Equatable {
    let id : String
    let name : String
    let price : Decimal
    let image : URL
    
    private static var currentID = 0
    
    init(id:String, name: String, price: String, image: URL) {
        self.id = "\(Product.currentID)"
        Product.currentID += 1
        
        self.name = name
        
        self.price = Decimal(string: price.replacingOccurrences(of: "£", with: "").trimmingCharacters(in: .whitespaces)) ?? 0
        self.image = URL(string:"https://placehold.co/250x250?text=Product")!
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  "\(Product.currentID)"
        Product.currentID += 1
        
        self.name = try container.decode(String.self, forKey: .name)
        let price = try container.decode(String.self, forKey: .price)
        self.price = Decimal(string: price.replacingOccurrences(of: "£", with: "").trimmingCharacters(in: .whitespaces)) ?? 0
        self.image = try container.decode(URL.self, forKey: .image)
    }
    
    func isEqualExcludingID(to other: Product) -> Bool {
        return self.name == other.name &&
        self.price == other.price &&
        self.image == other.image
    }
    
    static func areProductsEqual(_ array1: [Product], _ array2: [Product]) -> Bool {
        guard array1.count == array2.count else { return false }
        
        for (product1, product2) in zip(array1, array2) {
            if !product1.isEqualExcludingID(to: product2) {
                return false
            }
        }
        
        return true
    }
}
