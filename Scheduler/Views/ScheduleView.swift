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
    @Query var items: [Item]

    var body: some View {
        VStack {
            ItemTable(items: items)
        }
        .navigationTitle("Schedule")
    }
}
