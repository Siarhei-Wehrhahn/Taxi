//
//  OrderViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("order").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.orders = documents.compactMap { queryDocumentSnapshot in
                
                guard let order = try? queryDocumentSnapshot.data(as: Order.self) else {
                    print("Failed to decode order document with ID: \(queryDocumentSnapshot.documentID)")
                    return nil
                }
                return order
                
            }
        }
    }
    
    func markOrderAsTaken(_ order: Order) {
        if let orderIndex = self.orders.firstIndex(of: order) {
            self.orders[orderIndex].taken = true
            
            let orderRef = db.collection("order").document(order.id.uuidString)
            orderRef.updateData(["taken": true]) { error in
                if let error = error {
                    print("Error updating order: \(error.localizedDescription)")
                    print("Error code: \((error as NSError).code)")
                } else {
                    print("Order updated successfully")
                }
            }
        }
    }
}

