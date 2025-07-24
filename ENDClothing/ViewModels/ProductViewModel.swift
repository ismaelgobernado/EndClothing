//
//  ProductViewModel.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//
import Foundation

@MainActor
final class ProductViewModel: ObservableObject {
    @Published private(set) var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
}
