//
//  CoordinatorFasttrackView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 19/07/2025.
//


import SwiftUI

struct CoordinatorFasttrackView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Pages").fontWeight(.bold)
            ForEach (Page.allCases, id:\.self){ page in
                Button {
                    coordinator.push(page)
                } label: {
                    Text("  -  \(page.id)")
                }

            }
            Text("Sheets").fontWeight(.bold)
            ForEach (Sheet.allCases, id:\.self){ sheet in
                Button {
                    coordinator.present(sheet:sheet)
                } label: {
                    Text("  -  \(sheet.id)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    CoordinatorFasttrackView()
}
