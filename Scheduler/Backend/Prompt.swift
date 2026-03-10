//
//  Prompt.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/17/26.
//

import Foundation

func buildPrompt(for tasks: [Item]) -> String {
    
    let dtoTasks = tasks.map {
        ItemDTO(name: $0.name, date: $0.date, time: $0.time)
    }

    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted

    let jsonString: String

    do {
        let data = try encoder.encode(dtoTasks)
        jsonString = String(data: data, encoding: .utf8) ?? "[]"
    } catch {
        print("Encoding failed:", error)
        jsonString = "[]"
    }

    let formatter = ISO8601DateFormatter()
    let now = formatter.string(from: Date())
    
    print(tasks)
    print(Date())
    
    return """
    It is currently \(now). 
    Create a schedule for these items: \(jsonString)
    The structure of these tasks is:
    Name: String
    DueDate: ISO 8601 datetime
    Time: String in number of hours
    Return ONLY valid JSON in this format:
    [
      {
        "name": "task name exactly as provided",
        "start": "ISO 8601 datetime",
        "end": "ISO 8601 datetime"
      }
    ]
    IMPORTANT RULES:
    1. Output must be valid JSON
    2. Do not include markdown
    3. Do not include backticks
    4. Do not include explanations
    5. Be sure to schedule enough time for all hours the task requires
    6. If no tasks exist return: []
    7. Don't have start or end times between 1 am and 6 am
    """
}


//    return """
//        Create a schedule for these items:
//        \(tasks[0].name) (Takes \(tasks[0].time) and is due \(tasks[0].date),
//        \(tasks[1].name) (Takes \(tasks[1].time) and is due \(tasks[1].date).
//        It is currently \(Date()).
//        Don't give any description. Just give the schedule.
//        Return JSON with a task name called name, start time called start, and end time called end for each.
//        Return dates in the same time zone that the user is in based on the included date for today.
//        Make sure to schedule all items.
//        Don't schedule them for the day they are due if it can be avoided.
//        """
//    return "Create a schedule for these items: Math Homework (Takes two hours and is due 2/19),History Studying (Takes one hour and is due 2/20). It is currently \(Date()). Don't give any description. Just give the schedule."


//    return """
//        Create a schedule for these items: \(tasks)
//        It is currently \(Date()).
//        Only provide JSON as output
//        Place output in the response array
//        Return JSON with a task name called name, start time called start, and end time called end for each.
//        Return dates in the same time zone that the user is in based on the included date for today.
//        Make sure to schedule all items.
//        Don't schedule them for the day they are due if it can be avoided.
//        If there are no tasks provided to give a schedule for just return an EMPTY JSON list.
//        Don't create any more items
//        only use the provided items
//        Return only JSON, no markdown, no backticks
//        If possible avoid scheduling tasks from 1 am to 6 am
//        Don't change the name of the items from what they are passed in as
//        """
