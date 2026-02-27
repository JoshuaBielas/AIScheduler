//
//  Scheduled.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/27/26.
//

import Foundation
import SwiftData

@Model
class Scheduled: Identifiable {
    var id: UUID = UUID()
    var name: String
    var dueDate: Date
    var start: Date
    var end: Date
    
    init(name: String, dueDate: Date, start: Date, end: Date) {
        self.name = name
        self.dueDate = dueDate
        self.start = start
        self.end = end
    }
}
