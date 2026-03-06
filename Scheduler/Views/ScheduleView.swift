//
//  Schedule.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/20/26.
//

import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var dbContext
    @Query var scheduledItems: [ScheduledItem]

    var body: some View {
        VStack {
            ScheduledTable(scheduledItems: scheduledItems)
        }
        .navigationTitle("Schedule")
    }
}
