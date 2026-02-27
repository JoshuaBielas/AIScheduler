//
//  ContentView.swift
//  Scheduler
//
//  Created by Joshua Bielas on 1/29/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var testItems = Items()
    @State private var tempText: String = ""
//    @State private var prompt: String = "Create a schedule for these items: Math Homework (Takes two hours and is due 2/19),History Studying (Takes one hour and is due 2/20). It is currently \(Date()). Don't give any description. Just give the schedule."
    @State private var errorMessage: String?
    @Query var items: [Item]
    @Environment(\.modelContext) private var dbContext

    var body: some View {
        NavigationStack {
            VStack {
                ItemTable(items: items)
                    .frame(maxHeight: 500)
                Spacer()
                Text(tempText)
                Spacer()
                ZStack {
                    Button("Schedule Items") {
                        tempText = "\(items.count)"
//                        if(items.isEmpty) {
//                            errorMessage = "Please add items before scheduling."
//                            tempText = errorMessage ?? ""
//                            return
//                        }
//                        Task {
//                            do {
//                                let prompt: String = buildPrompt(for: items)
//                                let output = try await LLMCommunicator().getSchedule(prompt: prompt)
//                                self.tempText = output
//                                self.errorMessage = nil
//                            } catch {
//                                self.errorMessage = error.localizedDescription
//                            }
//                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .foregroundStyle(Color.white)
                    HStack {
                        NavigationLink {
                            AddItemView()
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
                            ScheduleView()
                        } label: {
                            Image(systemName: "list.clipboard")
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
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CalendarView()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
        }
//        .onAppear {
//            let container = dbContext.container
//            for config in container.configurations {
//                let url = config.url
//                print("SwiftData store URL:", url.path)
//            }
//        }
    }
}


#Preview {
    ContentView()
}

