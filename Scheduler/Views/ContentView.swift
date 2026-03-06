//
//  ContentView.swift
//  Scheduler
//
//  Created by Joshua Bielas on 1/29/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var tempText: String = ""
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
                        if(items.isEmpty) {
                            errorMessage = "Please add items before scheduling."
                            tempText = errorMessage ?? ""
                            return
                        }
                        Task {
                            do {
                                let prompt: String = buildPrompt(for: items)
                                let output = try await LLMCommunicator().getSchedule(prompt: prompt)
                                
                                try ScheduledItem.createFromLLMResponse(output, in: dbContext)
                                
//                                self.tempText = output
                                self.errorMessage = nil
                            } catch {
                                self.errorMessage = error.localizedDescription
                                print("Failed:", error)
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .foregroundStyle(Color.white)
//                    Button("Schedule Items") {
//                        Task {
//                            do {
//                                if items.isEmpty {
//                                    tempText = "No items to schedule."
//                                    return
//                                }
//                                let prompt = buildPrompt(for: items)
//                                let output = try await LLMCommunicator().getSchedule(prompt: prompt)
//
//                                print("LLM output:\n\(output)")
//                                tempText = "Got LLM output (\(output.count) chars), importing..."
//
//                                try ScheduledItem.createFromLLMResponse(output, in: dbContext)
//
//                                tempText = "Imported scheduled items successfully."
//                            } catch {
//                                tempText = "Scheduling failed: \(error.localizedDescription)"
//                                print("Scheduling failed:", error)
//                            }
//                        }
//                    }

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

