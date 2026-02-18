//
//  Table.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/10/26.
//

import SwiftUI

struct ItemRow: View {
    let item: Item

    var body: some View {
        HStack {
            Text(item.name)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(item.date, style: .date)
                .frame(width: 120, alignment: .leading)
            Text(item.time)
                .frame(width: 120, alignment: .leading)
        }
        .font(.body.monospacedDigit())
    }
}

struct ItemTable: View {
    @Binding var items: [Item]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Item")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Due Date")
                    .bold()
                    .frame(width: 120, alignment: .leading)
                Text("Expected Time")
                    .bold()
                    .frame(width: 120, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))

            List {
                ForEach(items) { item in
                    ItemRow(item: item)
                }
                .onDelete { indexSet in
                    items.remove(atOffsets: indexSet)
                }
            }.scrollContentBackground(.hidden).background(Color(.clear))
        }
        .padding(.horizontal)
    }
}
