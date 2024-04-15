//
//  AuthenticationViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 12.03.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationViewModel: ObservableObject {
    @Published var user: FireUser?
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert = false
    @Published var showPasswordAlert = false
    @Published var showEmailAlert = false
    @Published var showNickName = false
    @Published var showRegister = false
    
    @Published var isUserAvailable: Bool = true
    
    private var availabilityListener: ListenerRegistration?
    
    var userIsLoggedIn: Bool {
        self.user != nil
    }
    
    init() {
        self.checkLogin()
        startListeningToUserAvailability()
    }
    
    func startListeningToUserAvailability() {
        guard let currentUser = FirebaseManager.shared.authenticator.currentUser else {
            print("No user logged in.")
            return
        }
        let orderRef = Firestore.firestore().collection("user").document(currentUser.uid)
        
        // Listener für Änderungen an der "aviable" Variable hinzufügen
        orderRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            // Überprüfen, ob das Dokument existiert und Daten enthält
            guard document.exists else {
                print("Document does not exist")
                return
            }
            
            // Überprüfen, ob das "aviable" Feld im Dokument vorhanden ist
            if let aviable = document.data()?["aviable"] as? Bool {
                // Update des ViewModel basierend auf dem Wert von "aviable"
                self.isUserAvailable = aviable
            } else {
                print("Field 'aviable' does not exist or is not a boolean")
            }
        }
    }
    
    func stopAvailabilityListener() {
        availabilityListener?.remove()
    }
    
    func temporarilySetUnavailableForTenMinutes() {
        let orderRef = Firestore.firestore().collection("user").document(user!.id)
        
        // Zunächst auf false setzen
        orderRef.updateData(["aviable": false]) { error in
            if let error = error {
                print("Error updating order: \(error.localizedDescription)")
                print("Error code: \((error as NSError).code)")
            } else {
                print("Order updated successfully")
                
                // Timer für 10 Minuten erstellen
                DispatchQueue.main.asyncAfter(deadline: .now() + 300) { // 300 Sekunden = 5 Minuten
                    // Nach Ablauf des Timers den Wert wieder auf true setzen
                    orderRef.updateData(["aviable": true]) { error in
                        if let error = error {
                            print("Error updating order: \(error.localizedDescription)")
                            print("Error code: \((error as NSError).code)")
                        } else {
                            print("Order availability reset successfully")
                        }
                    }
                }
            }
        }
    }
    
    
    func createAnonym() {
        FirebaseManager.shared.authenticator.signInAnonymously { authResult, error in
            if let user = self.handleAuthResult(authResult: authResult, error: error) {
                self.createFireUser(id: user.uid, email: "Anonym", name: "Anonym")
            }
        }
    }
    
    func login() {
        FirebaseManager.shared.authenticator.signIn(withEmail: self.email, password: self.password) { authResult, error in
            if let user = self.handleAuthResult(authResult: authResult, error: error) {
                self.fetchFireUser(id: user.uid)
            }
        }
    }
    
    func register() {
        FirebaseManager.shared.authenticator.createUser(withEmail: self.email, password: self.password) { authResult, error in
            if let user = self.handleAuthResult(authResult: authResult, error: error) {
                self.createFireUser(id: user.uid, email: self.email, name: self.name)
            }
        }
    }
    
    func logout() {
        do {
            try FirebaseManager.shared.authenticator.signOut()
            self.user = nil
        } catch {
            print("error signing out: \(error)")
        }
    }
    
    func deleteAccount() {
        guard let currentUser = FirebaseManager.shared.authenticator.currentUser else {
            print("No user logged in.")
            return
        }
        
        // Löschen des Benutzers aus der Authentifizierung
        currentUser.delete { error in
            if let error = error {
                print("Error deleting user: \(error)")
            } else {
                print("User deleted successfully.")
                
                // Löschen der Benutzerdaten aus der Firestore-Datenbank
                let userId = currentUser.uid
                let userRef = FirebaseManager.shared.fireStore.collection("user").document(userId)
                
                userRef.delete { error in
                    if let error = error {
                        print("Error deleting user data: \(error)")
                    } else {
                        print("User data deleted successfully.")
                    }
                }
                self.user = nil
            }
        }
    }
    
    func deleteOrderFromDrivenOrders(orderID: UUID) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: No current user")
            return
        }
        
        let userDocumentRef = Firestore.firestore().collection("user").document(currentUserID)
        
        // Zuerst die aktuelle Liste der drivenOrders abrufen
        userDocumentRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }
            guard var userData = document?.data(),
                  var drivenOrders = userData["drivenOrders"] as? [[String: Any]] else {
                print("Invalid user data")
                return
            }
            
            // Die zu löschende Order finden und entfernen
            drivenOrders.removeAll { $0["id"] as? String == orderID.uuidString }
            
            // Die aktualisierte drivenOrders-Liste in Firestore speichern
            userDocumentRef.updateData(["drivenOrders": drivenOrders]) { error in
                if let error = error {
                    print("Error removing order from driven orders: \(error)")
                } else {
                    print("Order removed from driven orders successfully in Firebase")
                }
            }
        }
    }
    
    
    private func checkLogin() {
        guard let currentUser = FirebaseManager.shared.authenticator.currentUser else {
            print("user not logged in")
            return
        }
        
        self.fetchFireUser(id: currentUser.uid)
    }
    
    private func handleAuthResult(authResult: AuthDataResult?, error: Error?) -> User? {
        if let error {
            showAlert = true
            print("Error signing in : \(error)")
            return nil
        }
        
        guard let authResult else {
            print("auth result is empty!")
            
            return nil
        }
        
        return authResult.user
    }
    
    private func createFireUser(id: String, email: String, name: String) {
        
        let fireUser = FireUser(id: id, nickName: name, email: email, registeredAt: Date(), driver: false, aviable: true, favoriteTrip: [], drivenOrders: [])
        
        do {
            try FirebaseManager.shared.fireStore.collection("user").document(id).setData(from: fireUser)
            self.user = fireUser
        } catch {
            print("Could not create user: \(error)")
        }
    }
    
    
    private func fetchFireUser(id: String) {
        FirebaseManager.shared.fireStore.collection("user").document(id).getDocument { document, error in
            if let error {
                print("Error reading user with id \(id): \(error)")
                return
            }
            
            guard let document else {
                print("Document with id \(id) is empty")
                return
            }
            
            do {
                let fireUser = try document.data(as: FireUser.self)
                self.user = fireUser
            } catch {
                print("Decoding user failed with error \(error)")
            }
        }
    }
}

