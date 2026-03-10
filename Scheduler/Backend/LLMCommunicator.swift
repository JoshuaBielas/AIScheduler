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
    private let model: String = "llama3"
//    private let model: String = "gemma3:4b"
//    private let model: String = "gemma3:latest"
//    private let model: String = "deepseek-r1:latest"
//    private let model: String = "qwen3:latest"
//    private let model: String = "llama3.2:latest"
//    private let model: String = "aya:latest"
//    private let model: String = "phi4-mini:latest"
    
    func getSchedule(prompt: String) async throws -> String {
        // COULD TRY WITH CS AI SERVER
        guard let url = URL(string: "http://127.0.0.1:11434/api/generate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let body = LLMRequest(model: model, prompt: prompt, stream: false)
        
        print("sending request ...")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
                
        if let http = response as? HTTPURLResponse, http.statusCode != 200 {
            let bodyText = String(data: data, encoding: .utf8) ?? "<non-utf8 body>"
            throw NSError(
                domain: "LLMCommunicator",
                code: http.statusCode,
                userInfo: [NSLocalizedDescriptionKey: "Non-200 response: \(http.statusCode). Body: \(bodyText)"]
            )
        }
        
        print("got the response. now trying to decode")
        let rawText = String(data: data, encoding: .utf8) ?? "<non-utf8 body>"
        print("raw output: ", rawText)
        let decodedResponse = try JSONDecoder().decode(LLMResponse.self, from: data)
        
        return decodedResponse.response
    }
}
