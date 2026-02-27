//
//  Item.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/3/26.
//

import Foundation
import SwiftData

//struct Item: Identifiable {
//    let id = UUID()
//    var name: String
//    var date: Date
//    var time: String
//}

//@Observable
//final class Items {
//    var items: [Item] = []
//}

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
