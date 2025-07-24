//
//  CoordinatorTest.swift
//  ENDClothingTests
//
//  Created by Ismael Gobernado on 24/07/2025.
//

import XCTest
@testable import ENDClothing
import SwiftUI

final class CoordinatorTest: XCTestCase {
    
    var coordinator: Coordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = Coordinator()
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    /// Verifies that pushing a page updates the path correctly.
    func testPushPage() {
        let page = Page.products
        coordinator.push(page)
        print(coordinator.path)
        XCTAssertEqual(coordinator.path.count, 1, "Path should contain one page after push.")
    }
    
    /// Checks if popping a page removes it from the path.
    func testPopPage() {
        let page = Page.products
        coordinator.push(page)
        coordinator.pop()
        XCTAssertEqual(coordinator.path.count, 0, "Path should be empty after pop.")
    }
    
    /// Ensures that all pages are removed from the path when popping to root.
    @MainActor func testPopToRoot() {
        let product1 = Product(id: "1", name: "Product1", price: "£55", image: URL(string:"https://media.endclothing.com/media/product1.jpg")!)
        
        coordinator.push(Page.products)
        coordinator.push(Page.productDetail(productViewModel: ProductViewModel(product: product1)))
        coordinator.popToRoot()
        XCTAssertEqual(coordinator.path.count, 0, "Path should be empty after popping to root.")
    }
    
    /// Tests that presenting a sheet updates the sheet property.
    func testPresentSheet() {
        let sheet = Sheet.visualizationOptions
        coordinator.present(sheet: sheet)
        XCTAssertNotNil(coordinator.sheet, "Sheet should not be nil after presentation.")
        XCTAssertEqual(coordinator.sheet, sheet, "The presented sheet should be visualizationOptions.")
    }
    
    /// Confirms that dismissing a sheet sets it to nil.
    func testDismissSheet() {
        coordinator.present(sheet: Sheet.visualizationOptions)
        coordinator.dismissSheet()
        XCTAssertNil(coordinator.sheet, "Sheet should be nil after dismissal.")
    }
    
    /// Verifies the equality of pages.
    @MainActor func testPageIdentifiability() {
        let product1 = Product(id: "1", name: "Product1", price: "£55", image: URL(string:"https://media.endclothing.com/media/product1.jpg")!)
        
        let page1 = Page.products
        let page2 = Page.products
        let page3 = Page.productDetail(productViewModel: ProductViewModel(product: product1))
        
        XCTAssertEqual(page1, page2, "Identical pages should be equal.")
        XCTAssertNotEqual(page1, page3, "Different pages should not be equal.")
    }
    
    /// Checks the equality of sheets.
    func testSheetIdentifiability() {
        let sheet1 = Sheet.visualizationOptions
        let sheet2 = Sheet.visualizationOptions
        let sheet3 = Sheet.sortOptions(selectedSorting: Binding.constant(Sorting.low))
        
        XCTAssertEqual(sheet1, sheet2, "Identical sheets should be equal.")
        XCTAssertNotEqual(sheet1, sheet3, "Different sheets should not be equal.")
    }
    
    /// Validates the detents for a specific sheet.
    func testSheetDetents() {
        let sheet = Sheet.sortOptions(selectedSorting: Binding.constant(Sorting.low))
        let detents = sheet.detents()
        XCTAssertTrue(detents.contains(.medium), "Sort options should have a medium detent.")
    }
    
    /// Ensures the title for a sheet is correct.
    func testSheetTitle() {
        let sheet = Sheet.sortOptions(selectedSorting: Binding.constant(Sorting.low))
        let title = sheet.title()
        XCTAssertEqual(title, "Sort", "Title for sort options should be 'Sort'.")
    }
    
}
