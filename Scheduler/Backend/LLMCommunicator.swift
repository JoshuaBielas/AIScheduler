//
//  LLMCommunicator.swift
//  Scheduler
//
//  Created by Joshua Bielas on 2/11/26.
//  I got a lot of help from ChatGPT with writing this code
//

import Foundation

struct LLMResponse: Codable {
    let model: String
    let created_at: String
    let response: String
    let done: Bool
}

struct LLMRequest: Codable {
    let model: String
    let prompt: String
    let stream: Bool
}

class LLMCommunicator {
    func getSchedule(prompt: String) async throws -> String {
        guard let url = URL(string: "http://localhost:11434/api/generate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let body = LLMRequest(model: "llama3", prompt: prompt, stream: false)
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
                
        let decodedResponse = try JSONDecoder().decode(LLMResponse.self, from: data)
        
        return decodedResponse.response
    }
}
