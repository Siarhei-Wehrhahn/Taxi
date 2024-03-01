//
//  ChatViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 29.02.24.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []
    @Published var userInput = ""
    let repo = ChatRepository()
    
   
    func sendMessage(text: String) {
        Task {
            do {
                let result: () = repo.sendRequest(prompt: userInput) { result in
                    
                    switch result {
                    case .success(let response):
                            self.messages = self.repo.answere
                            print(self.messages)
                        
                    case .failure(let error):
                        print("Error sending message: \(error)")
                    }
                }
            }
        }
    }

}

