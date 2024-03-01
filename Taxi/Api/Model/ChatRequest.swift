//
//  ChatModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 29.02.24.
//

import Foundation

struct ChatResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let role: String
    let content: String
}
