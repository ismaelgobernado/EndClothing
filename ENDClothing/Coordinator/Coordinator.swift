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
    
    func detents() -> Set<PresentationDetent> {
        switch self {
        case .visualizationOptions:
            return [.medium]
        case .sortOptions:
            return [.medium]
        case .filterOptions:
            return [.large]
        }
    }
    
    func title() -> String {
        switch self {
        case .visualizationOptions:
            return "View"
        case .sortOptions:
            return "Sort"
        case .filterOptions:
            return "Filter"
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
        let detents = sheet.detents()
        let title = sheet.title()
        switch sheet {
        case .visualizationOptions:
            SheetView(content: {
                VisualizationOptionsView()
            }, title: title).presentationDetents(detents)
        case .sortOptions:
            SheetView(content: {
                SortOptionsView()
            }, title: title).presentationDetents(detents)
        case .filterOptions:
            SheetView(content: {
                FilterOptionsView()
            }, title: title).presentationDetents(detents)
        }
    }
}
