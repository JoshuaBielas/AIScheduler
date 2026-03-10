//
//  Item.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/3/26.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id: UUID = UUID()
    var name: String
    var date: Date
    var time: Int
    
    init(name: String, date: Date, time: Int) {
        self.name = name
        self.date = date
        self.time = time
    }
}


struct ItemDTO: Codable {
    let name: String
    let date: Date
    let time: Int
}
