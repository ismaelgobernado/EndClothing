//
//  ProductsViewModel.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//
import Foundation

@MainActor
final class ProductsViewModel: ObservableObject {
    
    @Published private(set) var title: String = ""
    @Published private(set) var products: [Product] = []
    @Published private(set) var productCount: Int = 0
    
    func fetchData() async {
        title = "title"
        
        let product1 = Product(id: "1", name: "Test Product 1", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product2 = Product(id: "2", name: "Test Product 2", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product3 = Product(id: "3", name: "Test Product 3", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product4 = Product(id: "4", name: "Test Product 4", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product5 = Product(id: "5", name: "Test Product 5", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        let product6 = Product(id: "6", name: "Test Product 6", price: "£10.99", image: URL(string: "https://placehold.co/250x250?text=Product")!)
        products = [product1, product2, product3, product4, product5, product6]
        
        productCount = 6
    }
    
}
