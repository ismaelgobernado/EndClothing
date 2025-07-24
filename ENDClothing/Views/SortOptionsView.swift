//
//  SortOptionsView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//

import SwiftUI

struct SortOptionsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @Binding var selectedSorting: Sorting
    
    var body: some View {
        VStack{
            ForEach(Sorting.allCases, id: \.self ) { value in
                HStack {
                    Button {
                        selectedSorting = value
                        coordinator.dismissSheet()
                    } label: {
                        Text(value.title).tint(Constants.textColor)
                    }
                    Spacer()
                    if selectedSorting == value{
                        Image(systemName: "checkmark")
                            .accessibilityIdentifier("checkmark")
                        
                    }
                }.padding()
                Rectangle()
                    .fill(.gray.opacity(0.35))
                    .frame(height: 0.5)
            }
            Spacer()
        }
    }
}

#Preview {
    SortOptionsView(selectedSorting: Binding.constant(Sorting.low))
}
