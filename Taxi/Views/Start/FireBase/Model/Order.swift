//
//  Order.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 14.03.24.
//

import Foundation
// Bestell informationen einfügen
struct Order: Codable, Identifiable, Hashable {
    var id: UUID
    let userId: String
    let userName: String
    let start: String
    let destination: String
    let time: Date
    let kids: Int?
    let luggage: Bool?
    let pets: Bool?
    let helpToSitIn: Bool?
    let passenger: Int?
    var taken: Bool
    var takenInMin10: Bool
}
