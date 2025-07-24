//
//  CoordinatorView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    let entryPoint: Page = .fasttrack
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: entryPoint)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }.environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
