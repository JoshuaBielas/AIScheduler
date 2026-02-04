//
//  Item.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/3/26.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var date: Date
    var time: String
}

struct ItemManager {
    
    func createItem(into itemsList: Items, newName: String, newDate: Date, newTime: String) {
        itemsList.items.append(Item(name: newName, date: newDate, time: newTime))
    }
}

@Observable
final class Items {
    var items: [Item] = []
}
