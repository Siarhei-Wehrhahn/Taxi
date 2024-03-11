//
//  FavoriteViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var trip: Trip = Trip(start: "", destination: "")
    @Published var listOfTrips: [Trip] = []
    
    func addTrip() {
        listOfTrips.append(trip)
    }
    
    func deleteAll() {
        listOfTrips = []
    }
    
    // Haptisches Feedback
}
