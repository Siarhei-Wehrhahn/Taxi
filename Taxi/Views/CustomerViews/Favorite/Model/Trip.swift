//
//  Trip.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import Foundation

struct Trip: Identifiable, Hashable {
    var id = UUID()
    var start: String
    var destination: String
}
