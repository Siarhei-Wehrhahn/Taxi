//
//  FavoriteViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import Foundation
import Firebase

class FavoriteViewModel: ObservableObject {
    @Published var trip: Trip = Trip(id: UUID(), start: "", destination: "")
    @Published var listOfTrips: [Trip] = []
    @Published var showSheet = false
    
    private var db = Firestore.firestore()
    private var favoriteTripListener: ListenerRegistration?
    
    func deleteAll() {
        listOfTrips = []
    }
    
    func addTripToFavorites() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: No current user")
            return
        }

        // Erstelle eine neue Instanz von Trip mit einer neuen UUID
        let newTrip = Trip(id: UUID(), start: trip.start, destination: trip.destination)

        let userDocumentRef = Firestore.firestore().collection("user").document(currentUserID)

        userDocumentRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }

            if let document = document, document.exists {
                // Wenn das Benutzerdokument existiert, füge den neuen Trip zu den Favoriten hinzu
                userDocumentRef.updateData(["favoriteTrip": FieldValue.arrayUnion([newTrip.asDictionary])]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        self.trip.start = ""
                        self.trip.destination = ""
                        print("Trip added to favorite trips successfully in Firebase")
                    }
                }
            } else {
                // Wenn das Benutzerdokument nicht existiert, lege eine neue Sammlung an und füge den neuen Trip hinzu
                userDocumentRef.setData(["favoriteTrip": [newTrip.asDictionary]]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Trip added to favorite trips successfully in Firebase")
                    }
                }
            }
        }
    }
    
    func loadFavoriteTrips() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: No current user")
            return
        }

        let userDocumentRef = db.collection("user").document(currentUserID)

        favoriteTripListener = userDocumentRef.addSnapshotListener { [weak self] (documentSnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot, document.exists else {
                print("User document does not exist")
                return
            }

            if let data = document.data(), let favoriteTripsData = data["favoriteTrip"] as? [[String: Any]] {
                // Map favoriteTrip data to Trip objects and store in listOfTrips
                self.listOfTrips = favoriteTripsData.compactMap { tripData in
                    guard let idString = tripData["id"] as? String,
                          let id = UUID(uuidString: idString),
                          let start = tripData["start"] as? String,
                          let destination = tripData["destination"] as? String else {
                        return nil
                    }
                    return Trip(id: id, start: start, destination: destination)
                }
            } else {
                print("Favorite trips data not found")
            }
        }
    }
}

extension Trip {
    var asDictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "start": start,
            "destination": destination
        ]
    }
}
