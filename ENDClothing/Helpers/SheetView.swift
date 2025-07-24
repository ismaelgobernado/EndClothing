//
//  SheetView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

struct SheetView <Content: View>: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @ViewBuilder var content: Content
    @State var title: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.gray.opacity(0.35))
                    .frame(height: 0.5)
                Spacer()
                content
                
            }.navigationTitle(title.uppercased())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            coordinator.dismissSheet()
                        }) {
                            Image(systemName: "xmark").tint(.gray)
                                .accessibilityIdentifier("xmark")
                        }
                    }
                }
        }
    }
}
