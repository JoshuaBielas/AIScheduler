//
//  AddItem.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/3/26.
//
import SwiftUI

struct AddItemView: View {
    let itemStore: Items
    @State private var name = ""
    @State private var date = Date()
    @State private var time = ""

    var body: some View {
        VStack {
            Text("Enter the Name of the Item")
                .bold()
                .font(.title2)
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(50)
            Text("Select the Due Date for the Item")
                .bold()
                .font(.title2)
            DatePicker(
                "Due Date",
                selection: $date
            ).padding(50)
            Text("Enter the Expected Time for the Item")
                .bold()
                .font(.title2)
            TextField("Time", text: $time)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
                .padding(50)
            
            Button("Create Item"){
                itemStore.items.append(Item(name: name, date: date, time: time))
            }
        }
        .navigationTitle("Add Item")
    }
}
