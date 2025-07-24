//
//  GridRowProduct.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 21/07/2025.
//

import SwiftUI
import Kingfisher

struct GridRowProduct: View {
    var product: Product
    @State var isFavourite: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            KFImage.url(product.image)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: Constants.fadeDuration)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityIdentifier("product.image\(product.image.lastPathComponent)")
                .padding()
            Text(product.name)
            HStack {
                Text("£ \(product.price)")
                Spacer()
                Button {
                    isFavourite.toggle()
                } label: {
                    Image(systemName: isFavourite ? "heart.fill": "heart")
                        .accessibilityIdentifier(isFavourite ? "heart.fill" : "heart")
                        .frame(width: Constants.favouriteSize, height: Constants.favouriteSize, alignment: .center)
                        .aspectRatio(contentMode: .fit).cornerRadius(8)
                        .animation(.easeOut, value: true).tint(.gray)
                }
                
            }
        }.padding()
        
    }
}
