//
//  Scheduled.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/27/26.
//  I got a lot of help from ChatGPT on this code because I wasn't sure how to do it
//

import Foundation
import SwiftData

@Model
final class ScheduledItem {
    var name: String
//    var dueDate: Date
    var start: Date
    var end: Date

//    init(name: String, dueDate: Date, start: Date, end: Date) {
//        self.name = name
//        self.dueDate = dueDate
//        self.start = start
//        self.end = end
//    }
    init(name: String, start: Date, end: Date) {
        self.name = name
        self.start = start
        self.end = end
    }
}

// A lightweight DTO that matches the JSON coming from your LLM
private struct ScheduledItemDTO: Decodable {
    let name: String
//    let dueDate: Date
    let start: Date
    let end: Date
}

extension ScheduledItem {
    static func createFromLLMResponse(_ llmResponse: String, in context: ModelContext) throws {
        // 1) Extract the JSON array substring between the first '[' and the last ']'
        guard let startBracket = llmResponse.firstIndex(of: "["),
              let endBracket = llmResponse.lastIndex(of: "]") else {
            throw NSError(domain: "ScheduledItem", code: 1, userInfo: [NSLocalizedDescriptionKey: "No JSON array found in response"])
        }

        let jsonSubstring = llmResponse[startBracket...endBracket]
        let jsonData = Data(jsonSubstring.utf8)

        // 2) Decode using a date strategy that matches your LLM output (adjust if needed)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let dtos = try decoder.decode([ScheduledItemDTO].self, from: jsonData)

        // 3) Create and insert models
        for dto in dtos {
//            let model = ScheduledItem(name: dto.name, dueDate: dto.dueDate, start: dto.start, end: dto.end)
            let model = ScheduledItem(name: dto.name, start: dto.start, end: dto.end)
            context.insert(model)
        }

        // 4) Save explicitly to persist immediately
        try context.save()
    }
}
