//
//  SettingsViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 15.03.24.
//
import FirebaseStorage
import FirebaseFirestore
import Foundation
import UIKit

class SettingsViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var imageURL: URL?
    
    func uploadProfileImage(completion: @escaping (Error?) -> Void) {
        guard let imageData = profileImage?.jpegData(compressionQuality: 0.8) else {
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not convert image to data"]))
            return
        }
        
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(error)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let downloadURL = url {
                    self.imageURL = downloadURL
                    
                    // Speichern der Bild-URL in Firestore
                    let userId = FirebaseManager.shared.authenticator.currentUser!.uid
                    let userRef = Firestore.firestore().collection("users").document(userId)
                    userRef.updateData(["profileImageURL": downloadURL.absoluteString]) { error in
                        if let error = error {
                            completion(error)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
}
