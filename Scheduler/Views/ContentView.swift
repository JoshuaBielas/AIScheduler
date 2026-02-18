//
//  ContentView.swift
//  Scheduler
//
//  Created by Joshua Bielas on 1/29/26.
//

import SwiftUI

struct ContentView: View {
//    @State private var showForm = false
    @State private var testItems = Items()
    @State private var tempText: String = ""
    // I NEED TO BUILD THE PROMPT SOMEHOW PROBABLY WITHIN A FUNCTION
    // DATE SHOULD USE A DIFFERENT TIME ZONE
//    @State private var prompt: String = "Create a schedule for these items: Math Homework (Takes two hours and is due 2/19),History Studying (Takes one hour and is due 2/20). It is currently \(Date()). Don't give any description. Just give the schedule."
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ItemTable(items: $testItems.items)
                    .frame(maxHeight: 500)
                Spacer()
                Text(tempText)
                Spacer()
                ZStack {
                    Button("Schedule Items") {
                        if(testItems.items.isEmpty) {
                            errorMessage = "Please add items before scheduling."
                            tempText = errorMessage ?? ""
                            return
                        }
                        Task {
                            do {
                                let prompt: String = buildPrompt(for: testItems.items)
                                let output = try await LLMCommunicator().getSchedule(prompt: prompt)
                                self.tempText = output
                                self.errorMessage = nil
                            } catch {
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }.buttonStyle(.bordered).controlSize(.large)
                    HStack {
                        NavigationLink {
                            AddItemView(itemStore: testItems)
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        .controlSize(.large)
                        .padding(.leading, 16)
                        Spacer()
                        NavigationLink {
                            CalendarView(itemStore: testItems)
                        } label: {
                            Image(systemName: "calendar")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        .controlSize(.large)
                        .padding(.trailing, 16)
                    }
                }
            }
//            .navigationDestination(isPresented: $showForm) {
//                AddItemView(itemStore: testItems)
//            }
            .navigationTitle("Home")
        }
    }
}


#Preview {
    ContentView()
}

