//
//  Order.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 14.03.24.
//

import Foundation
// Bestell informationen einfügen
struct Order: Identifiable {
    let id = UUID()
    let start: String
    let destination: String
    let kids: Int?
    let luggage: Bool?
    let pets: Bool?
    let helpToSitIn: Bool?
    let passenger: Int?
}
