//
//  Item.swift
//  CarouselSwiftUI
//
//  Created by Sraavan Chevireddy on 26/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
