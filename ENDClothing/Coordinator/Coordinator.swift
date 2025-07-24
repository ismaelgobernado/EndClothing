//
//  Coordinator.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

enum Page: Identifiable, CaseIterable {
    
    case fasttrack,products, productDetail
    
    var id: String {
        return switch self {
        case .fasttrack : "fasttrack"
        case .products : "products"
        case .productDetail : "productDetail"
        }
    }
}

enum Sheet: Identifiable, CaseIterable {
    case visualizationOptions, sortOptions, filterOptions
    
    var id: String {
        return switch self {
        case .visualizationOptions : "visualizationOptions"
        case .sortOptions: "sortOptions"
        case .filterOptions: "filterOptions"
        }
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(sheet:Sheet){
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(page:Page) -> some View {
        switch page {
        case .products:
            ProductsView()
        case .productDetail:
            ProductDetailView()
        case .fasttrack:
            CoordinatorFasttrackView()
        }
    }
    
    @ViewBuilder
    func build(sheet:Sheet) -> some View {
        switch sheet {
        case .visualizationOptions:
            SheetView(content: {
                VisualizationOptionsView()
            }, title: "View")
        case .sortOptions:
            SheetView(content: {
                SortOptionsView()
            }, title: "Sort")
        case .filterOptions:
            SheetView(content: {
                FilterOptionsView()
            }, title: "Filter")
        }
    }
}
