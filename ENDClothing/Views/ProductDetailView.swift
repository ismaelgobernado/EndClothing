//
//  ProductDetailView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    var viewModel : ProductViewModel
    
    var body: some View {
        Text(viewModel.product.name)
    }
}

#Preview {
    ProductDetailView(viewModel:  ProductViewModel(product: Product(id: "1", name: "Product 1", price: "£25", image: URL(string:"https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg")!)))
}
