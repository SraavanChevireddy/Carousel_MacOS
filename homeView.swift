//
//  homeView.swift
//  CarouselSwiftUI
//
//  Created by Sraavan Chevireddy on 26/10/23.
//

import SwiftUI

struct HomeView: View {
    @State var currentIndex: Int = 0
    @State var animationIndex: Int = 0
    @State var items: [CarouselItems] = []
    
    @State private var showDetails: Bool = true
    
    var body: some View {
        VStack(spacing:  15) {
            VStack(alignment: .leading, spacing: 12) {
                Button {
                        
                } label: {
                    Label("Back", systemImage: "ev.charger.arrowtriangle.left")
                }.tint(.black)
                Text("Carousel")
                    .font(.system(.title, design: .rounded, weight: .bold))
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            // Carousel
            SnapCarouselView(trailingSpace: 60, index: $currentIndex, animationIndex: $animationIndex, items: items) { eachCarouselItem in
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    VStack {
                        Image(eachCarouselItem.postImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: 200)
                            .cornerRadius(12)
                        
                        if eachCarouselItem.index == currentIndex {
                            Text("Header Content")
                                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("want to create a multiline text view with bullet points indented to the right. The text following these bullet points is long and is looping to the next row, which I want. However, the part that is being looped is not keeping the original indentation that I gave the line. This is my code:")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                    }.animation(.easeIn, value: animationIndex == eachCarouselItem.index)
                }
            }
            .padding(.vertical, 80)
        }.frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                for index in 0...4 {
                    items.append(CarouselItems(index: index, postImage: "\(index)"))
                }
            }
    }
}

#Preview {
    HomeView()
}
