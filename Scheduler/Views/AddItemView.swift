//
//  AddItem.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/3/26.
//
import SwiftUI
import SwiftData

struct AddItemView: View {
    @Query var items: [Item]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var dbContext
    @State private var name = ""
    @State private var date = Date()
    @State private var time = 0

    var body: some View {
        VStack {
            Form {
                Section() {TextField("Name", text: $name)}
                Section() {DatePicker("Due Date", selection: $date)}
                Section() {TextField("Time", value: $time, format: .number)
                    .keyboardType(.numberPad)}
            }
            Button("Create Item"){
                dbContext.insert(Item(name: name, date: date, time: time))
                do {
                    try dbContext.save()
                } catch {
                    print("insert failed", error)
                }
                dismiss()
            }.buttonStyle(.bordered).controlSize(.large)
        }
        .navigationTitle("Add Item")
    }
}

