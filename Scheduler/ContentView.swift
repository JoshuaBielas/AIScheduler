//
//  ContentView.swift
//  Scheduler
//
//  Created by Joshua Bielas on 1/29/26.
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
    let items: [Item]

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

            // Rows
            List(items) { item in
                ItemRow(item: item)
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
    }
}

struct ContentView: View {
    @State private var showForm = false
    @State private var testItems = Items()
    private let itemManager = ItemManager()

    var body: some View {
        
//        let testItems: [Item] = [
//            Item(name: "Item1", date: .now, time: "3 hours"),
//            Item(name: "Item2", date: .now, time: "4 hours"),
//            Item(name: "Item3", date: .now, time: "1 hour")
//        ]
//        ItemTable(items: testItems.items)
        
        NavigationStack {
            VStack {
                Spacer()
                ItemTable(items: testItems.items)
                    .frame(maxHeight: 500)
                Spacer()
                Spacer()
                Button("Add Item") {
                    showForm = true
//                    itemManager.createItem(into: testItems, newName: "New Item", newDate: Date(), newTime: "1 hour")
                }.buttonStyle(.bordered).controlSize(.large)
            }
            .navigationDestination(isPresented: $showForm) {
//                AddItemView()
                AddItemView(itemStore: testItems)
            }
            .navigationTitle("Home")
        }
    }
}


#Preview {
    ContentView()
}
