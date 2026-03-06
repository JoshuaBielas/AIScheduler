//
//  ScheduledTable.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/26/26.
//

import SwiftUI
import SwiftData

struct ScheduledRow: View {
    let scheduledItem: ScheduledItem
    @Environment(\.modelContext) private var dbContext

    var body: some View {
        HStack {
            Text(scheduledItem.name)
                .frame(maxWidth: .infinity, alignment: .leading)
//            Text("\(scheduledItem.dueDate)")
//                .frame(width: 120, alignment: .leading)
            Text("\(scheduledItem.start)")
                .frame(width: 120, alignment: .leading)
            Text("\(scheduledItem.end)")
                .frame(width: 120, alignment: .leading)
        }
        .font(.body.monospacedDigit())
    }
}

struct ScheduledTable: View {
    let scheduledItems: [ScheduledItem]
    @Environment(\.modelContext) private var dbContext
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Item")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Start")
                    .bold()
                    .frame(width: 120, alignment: .leading)
                Text("End")
                    .bold()
                    .frame(width: 120, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
            
            List {
                ForEach(scheduledItems) { scheduledItem in
                    ScheduledRow(scheduledItem: scheduledItem)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        dbContext.delete(scheduledItems[index])
                    }
                    do {
                    try dbContext.save()
                        print("delete succeeded")
                    } catch {
                        print("Delete save failed:", error)
                    }
                }
            }.scrollContentBackground(.hidden).background(Color(.clear))
        }
        .padding(.horizontal)
    }
}
