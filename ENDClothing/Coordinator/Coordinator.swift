//
//  Coordinator.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

enum Page: Identifiable, Hashable {
    
    case products, productDetail(productViewModel:ProductViewModel)
    
    var id: String {
        return switch self {
        case .products : "products"
        case .productDetail : "productDetail"
        }
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Sheet: Identifiable, Hashable, Equatable {
    case visualizationOptions, sortOptions(selectedSorting: Binding<Sorting>), filterOptions
    
    var id: String {
        return switch self {
        case .visualizationOptions : "visualizationOptions"
        case .sortOptions(selectedSorting: _): "sortOptions"
        case .filterOptions: "filterOptions"
        }
    }
    
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
        case .productDetail(let viewModel):
            ProductDetailView(viewModel: viewModel)
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
        case .sortOptions(let selectedSorting):
            SheetView(content: {
                SortOptionsView(selectedSorting: selectedSorting)
            }, title: title).presentationDetents(detents)
        case .filterOptions:
            SheetView(content: {
                FilterOptionsView()
            }, title: title).presentationDetents(detents)
        }
    }
}
