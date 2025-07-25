//
//  ResizableHeaderScrollView.swift
//  ENDClothing
//
//  Created by Ismael Gobernado on 20/07/2025.
//

import SwiftUI

struct ResizableHeaderScrollView <Header: View, Background:View, Content: View>: View {
    var spacing: CGFloat = 10
    @ViewBuilder var header: Header
    @ViewBuilder var background: Background
    @ViewBuilder var content: Content
    @State private var currentDragOffset: CGFloat = 0
    @State private var previousDragOffset: CGFloat = 0
    @State private var headerOffset: CGFloat = 0
    @State private var headerSize: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    
    
    var body: some View {
        if #available(iOS 18.0, *) {
            ScrollView(.vertical) {
                content
            }
            .frame(maxWidth: .infinity)
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentOffset.y + $0.contentInsets.top
            }, action: { oldValue, newValue in
                scrollOffset = newValue
            })
            .simultaneousGesture(
                DragGesture(minimumDistance: 10)
                    .onChanged({ value in
                        let dragOffset = -max(0, abs(value.translation.height) - 50) * (value.translation.height < 0 ? -1 : 1)
                        
                        previousDragOffset = currentDragOffset
                        currentDragOffset = dragOffset
                        
                        let deltaOffset = (currentDragOffset - previousDragOffset).rounded()
                        
                        headerOffset = max(min(headerOffset + deltaOffset, headerSize),0)
                    }).onEnded({ _ in
                        withAnimation (.easeInOut(duration: 0.2)) {
                            if headerOffset > (headerSize * 0.5) && scrollOffset > headerSize {
                                headerOffset = headerSize
                            } else {
                                headerOffset = 0
                            }
                        }
                        
                        currentDragOffset = 0
                        previousDragOffset = 0
                    })
            )
            .safeAreaInset(edge: .top, spacing: spacing){
                CombinedHeaderView()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @ViewBuilder
    private func CombinedHeaderView() -> some View {
        VStack(spacing: spacing) {
            header
                .onGeometryChange(for: CGFloat.self){
                    $0.size.height
                } action: { newValue in
                    headerSize = newValue + spacing
                }
        }
        .offset(y: -headerOffset)
        .clipped()
        .background {
            background
                .ignoresSafeArea()
                .offset(y: -headerOffset)
        }
    }
}

