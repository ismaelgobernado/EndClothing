//
//  HeaderView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 20/07/2025.
//

import SwiftUI

struct Constants {
    static let borderOpacity: Double = 0.3
    static let backgroundColor = Color.white
    static let borderColor = Color.gray
    static let grayTextColor = Color.gray
    static let textColor = Color.black
    static let headerHeight: CGFloat = 50.0
    static let fadeDuration: TimeInterval = 0.25
    static let favouriteSize: CGFloat = 15.0
}

struct HeaderView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @Binding var selectedSorting: Sorting
    
    var body: some View {
        HStack (spacing: 0){
            Button(action: {
                coordinator.present(sheet: .sortOptions(selectedSorting: $selectedSorting))
            }) {
                ZStack {
                    Rectangle()
                        .fill(Constants.backgroundColor)
                        .border(Constants.borderColor).opacity(Constants.borderOpacity)
                    Text("Sort").tint(Constants.grayTextColor)
                }
            }
            Button(action: {
                coordinator.present(sheet: .visualizationOptions)
            }) {
                ZStack {
                    Rectangle()
                        .fill(Constants.backgroundColor)
                        .border(Constants.borderColor).opacity(Constants.borderOpacity)
                    Text("View").tint(Constants.grayTextColor)
                }
            }
            Button(action: {
                coordinator.present(sheet: .filterOptions)
            }) {
                ZStack {
                    Rectangle()
                        .fill(Constants.backgroundColor)
                        .border(Constants.borderColor).opacity(Constants.borderOpacity)
                    Text("Filter").tint(Constants.grayTextColor)
                }
            }
        }.frame(maxHeight: Constants.headerHeight)
    }
}


