//
//  ChatRepository.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 29.02.24.
//

import Foundation

class ChatRepository: ObservableObject {
    
    enum RequestError: Error {
        case unknownError
        case encodingError
        case decodingError
    }

    func sendRequest(prompt: String) async throws -> String {
        // Die URL zur API
        let apiUrl = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        // Dein API-Schlüssel
        let apiKey = "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"
        
        // Die Daten für die Chat-Anfrage
        let requestData: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": "Who won the world series in 2020?"],
                ["role": "assistant", "content": "The Los Angeles Dodgers won the World Series in 2020."],
                ["role": "user", "content": prompt]
            ]
        ]
        
        // Die Anfrage erstellen
        var urlRequest = URLRequest(url: apiUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Die Anfragedaten kodieren
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            urlRequest.httpBody = jsonData
        } catch {
            throw RequestError.encodingError
        }
        
        // Die Anfrage senden
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        // Die Antwort decodieren
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ChatResponse.self, from: data)
            
            // Die Antwort verarbeiten
            let answer = response.choices.first?.message.content ?? "No response"
            return answer
        } catch {
            throw RequestError.decodingError
        }
    }
}
