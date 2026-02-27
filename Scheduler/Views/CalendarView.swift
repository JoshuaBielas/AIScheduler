//
//  CalendarView.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/17/26.
//  Credit to https://www.youtube.com/watch?v=X_boPC1tg_Y
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var dbContext
    let daysOfWeek = ["S", "M", "T", "W", "Th", "F", "Sa"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    @State private var color = Color.gray
    @State private var date = Date.now

    var body: some View {
        VStack {
            LabeledContent("Date/Time"){
                DatePicker("", selection: $date)
            }
            .padding(.bottom, 40)
            HStack{
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 10)
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                Rectangle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay
                                        ? .blue.opacity(0.3)
                                        : color.opacity(0.3)
                                    )
                            )
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
        .navigationTitle(Text("Calendar"))
    }
}
