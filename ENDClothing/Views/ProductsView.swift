//
//  ProductsView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = ProductsViewModel()
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 250, maximum: 300)),
        GridItem(.adaptive(minimum: 250, maximum: 300))
    ]
    
    var body: some View {
        ResizableHeaderScrollView {
            HeaderView()
        }background: {
            Rectangle().fill(.white)
        } content: {
            Spacer(minLength: 15)
            Text("\(viewModel.productCount) Items").tint(.black)
            LazyVGrid(columns: columns) {
                ForEach (viewModel.products) { product in
                    GridRow {
                        Text("\(product.name)")
                    }.onTapGesture {
                        withAnimation {
                            coordinator.push(.productDetail(productViewModel: ProductViewModel(product:product)))
                        }
                    }
                }
            }
            Spacer()
        }.task {
            await viewModel.fetchData()
        }.navigationTitle(viewModel.title.uppercased())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "info.circle").tint(.gray)
                            .accessibilityIdentifier("info.circle")
                        
                    }
                }
            }
    }
}

#Preview {
    ProductsView()
}
