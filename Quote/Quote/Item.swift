//
//  Item.swift
//  Quote
//
//  Created by Roman Zhyravlev on 3/16/26.
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
