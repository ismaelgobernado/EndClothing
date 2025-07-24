//
//  ProductsViewModel.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import Foundation
import Combine

enum Sorting : String, CaseIterable {
    case none, low, high
    
    var title: String {
        return switch self {
        case .none : "None"
        case .low: "Price(low)"
        case .high: "Price(high)"
        }
    }
}

@MainActor
final class ProductsViewModel: ObservableObject {
    
    @Published private(set) var title: String = ""
    @Published private(set) var products: [Product] = []
    @Published private(set) var productCount: Int = 0
    
    @Published var selectedSorting: Sorting = .none {
        didSet {
            sortProducts()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    let networkService: NetworkService
    private var productListing: ProductListing?
    
    
    private func sortProducts() {
        if selectedSorting != .none {
            products.sort {
                selectedSorting == .low ? $0.price < $1.price : $0.price > $1.price
            }
        }
    }
    
    init(networkService: NetworkService = NetworkService(), products: [Product] = []) {
        self.networkService = networkService
        self.products = products
    }
    
    func fetchData() async {
        networkService.fetchItems(EndClothingEndpoints.catalog)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.handleError(completion)
            } receiveValue: { [weak self] productListing in
                guard let self = self else { return }
                self.productListing = productListing
                self.title = self.productListing?.title ?? ""
                self.products = self.productListing?.products ?? []
                self.productCount = self.productListing?.productCount ?? 0
            }.store(in: &cancellables)
    }
    
    private func handleError(_ completion: Subscribers.Completion<NetworkError>) {
        if case .failure(let error) = completion {
            print("🔴 Failure: \(error)")
        }
    }
    
    
    
}
