//
//  AuthenticationViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 12.03.24.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var user: FireUser?
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    var userIsLoggedIn: Bool {
        self.user != nil
    }
    
    init() {
        self.checkLogin()
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
    
    private func checkLogin() {
        guard let currentUser = FirebaseManager.shared.authenticator.currentUser else {
            print("user not logged in")
            return
        }
        
        self.fetchFireUser(id: currentUser.uid)
    }
    
    private func handleAuthResult(authResult: AuthDataResult?, error: Error?) -> User? {
        if let error {
            // TODO Alert bei gleicher email
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
        let fireUser = FireUser(id: id, nickName: name, email: email, registeredAt: Date())
        
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
    
    func isValidEmail() -> Bool {
            let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPredicate.evaluate(with: email)
        }
}

