//
//  Item.swift
//  Frisa
//
//  Created by Fernando Martínez on 17/09/23.
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
