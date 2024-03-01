//
//  ChatRepository.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 29.02.24.
//

import Foundation

class ChatRepository: ObservableObject {
    @Published var answere: [String] = []
    
    func sendRequest(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        
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
            print("Error encoding request data: \(error)")
        }
        
        // Die Anfrage senden
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Die Antwort decodieren
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ChatResponse.self, from: data)
                
                // Die Antwort verarbeiten
                self.answere.append(response.choices.first?.message.content ?? "No response")
                print(self.answere)
            } catch {
                print("Error decoding response: \(error)")
            }
        }
        task.resume()
    }
}
