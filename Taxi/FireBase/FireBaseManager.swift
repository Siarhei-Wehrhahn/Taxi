//
//  FireBaseManager.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 12.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    let authenticator = Auth.auth()
    let fireStore = Firestore.firestore()
    
    var userId: String? {
        authenticator.currentUser?.uid
    }
    private var availabilityListener: ListenerRegistration?
    
//    func startAvailabilityListener(forUserID userID: String, onChange: @escaping (Bool) -> Void) {
//        let userRef = fireStore.collection("user").document(userID)
//        
//        availabilityListener = userRef.addSnapshotListener { snapshot, error in
//            guard let snapshot = snapshot, snapshot.exists else {
//                print("Error fetching user document: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            if let data = snapshot.data(), let aviable = data["aviable"] as? Bool {
//                onChange(aviable)
//            } else {
//                print("Error parsing availability data")
//            }
//        }
//    }
//    
//    func stopAvailabilityListener() {
//        availabilityListener?.remove()
//    }
}


