//
//  ChatViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 29.02.24.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []
    @Published var userMessages: [String] = []
    @Published var userInput = ""
    @Published var showAlert = false
    let repo = ChatRepository()
    
    @MainActor
    func sendMessage() {
        Task {
            do {
                let result = try await repo.sendRequest(prompt: userInput)
                messages.append(result)
                userMessages.append(userInput)
                userInput = ""
            } catch {
                print(error)
            }
        }
    }
}
    
    
    
