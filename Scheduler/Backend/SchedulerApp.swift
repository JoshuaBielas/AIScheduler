//
//  SchedulerApp.swift
//  Scheduler
//
//  Created by Joshua Bielas on 1/29/26.
//

import SwiftUI
import SwiftData

@main
struct SchedulerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Item.self, ScheduledItem.self])
    }
}
