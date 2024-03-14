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
    @Published var showSheet = false
    
    func addTrip() {
        let newTrip = Trip(start: trip.start, destination: trip.destination)
        listOfTrips.append(newTrip)
    }
    
    func deleteAll() {
        listOfTrips = []
    }
    
    // Haptisches Feedback
}
