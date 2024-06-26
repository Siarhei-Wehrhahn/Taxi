//
//  FireUser.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 12.03.24.
//

import Foundation

struct FireUser: Codable {
    let id: String
    let nickName: String
    let email: String
    let registeredAt: Date
    let driver: Bool
    var aviable: Bool
    let favoriteTrip: [Trip]
    let drivenOrders: [Order]
}

struct Trip: Identifiable, Hashable, Codable {
    var id: UUID
    var start: String
    var destination: String
}
