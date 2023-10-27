//
//  SnapCarouselView.swift
//  CarouselSwiftUI
//
//  Created by Sraavan Chevireddy on 26/10/23.
//

import SwiftUI

struct SnapCarouselView<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    @Binding var animationIndex: Int
    
    init(spacing: CGFloat =  15, trailingSpace: CGFloat = 100, index: Binding<Int>, animationIndex: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self._animationIndex = animationIndex
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = (proxy.size.width - (trailingSpace - spacing))
            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }.padding(.horizontal, spacing)
                .offset(x: CGFloat(currentIndex) * -width + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            print("CRRENT \(currentIndex) INDEX \(index)")
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                            
                            // Updating the index
                            currentIndex = index
                            animationIndex = index
                        }).onChanged ({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        })
                )
        }.animation(.linear(duration: 0.4), value: offset == 0)
    }
}

