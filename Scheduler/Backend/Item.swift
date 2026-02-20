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

@Observable
final class Items {
    var items: [Item] = []
}
