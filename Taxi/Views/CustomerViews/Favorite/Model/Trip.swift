//
//  Trip.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import Foundation

class Trip: ObservableObject, Identifiable {
    @Published var start: String
    @Published var destination: String
    
    init(start: String, destination: String) {
        self.start = start
        self.destination = destination
    }
}
