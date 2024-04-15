//
//  OrderViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
import Combine

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var drivenOrders: [Order] = []
    private var listener: ListenerRegistration?

    let db = Firestore.firestore()

    init() {
        fetchOrder()
    }

    deinit {
        listener?.remove()
    }
    
    func shouldShowDateSeparator(for order: Order) -> Bool {
        guard let index = self.drivenOrders.firstIndex(of: order) else { return false }
        if index == 0 {
            return true
        } else {
            let previousOrder = self.drivenOrders[index - 1]
            return !Calendar.current.isDate(order.time, inSameDayAs: previousOrder.time)
        }
    }

    func fetchData() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: No current user")
            return
        }
        
        db.collection("user").document(currentUserID).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            do {
                if let user = try snapshot.data(as: FireUser?.self) {
                    self.drivenOrders = user.drivenOrders
                } else {
                    print("Document does not exist or could not be decoded as FireUser")
                }
            } catch {
                print("Error decoding document: \(error.localizedDescription)")
            }
        }
    }
    
    func addOrderToDrivenOrders(order: Order) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: No current user")
            return
        }
        
        let userDocumentRef = Firestore.firestore().collection("user").document(currentUserID)
        
        userDocumentRef.getDocument { [weak self] (document, error) in
            guard self != nil else { return }
            
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                // Wenn das Benutzerdokument existiert, füge die Order zu den drivenOrders hinzu
                userDocumentRef.updateData(["drivenOrders": FieldValue.arrayUnion([order.asDictionary])]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Order added to driven orders successfully in Firebase")
                        self!.deleteOrder(orderID: order.id)
                    }
                }
            } else {
                // Wenn das Benutzerdokument nicht existiert, lege eine neue Sammlung an und füge die Order hinzu
                userDocumentRef.setData(["drivenOrders": [order.asDictionary]]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Order added to driven orders successfully in Firebase")
                        self!.deleteOrder(orderID: order.id)
                    }
                }
            }
        }
    }
    
    func deleteOrder(orderID: UUID) {
        let orderDocumentRef = Firestore.firestore().collection("order").document(orderID.uuidString)
        
        orderDocumentRef.delete { error in
            if let error = error {
                print("Error deleting order: \(error.localizedDescription)")
            } else {
                print("Order deleted successfully")
                // Wenn die Bestellung erfolgreich gelöscht wurde, entferne sie auch aus der lokalen Liste
                self.orders.removeAll { $0.id == orderID }
            }
        }
    }
    
    
    func fetchOrder() {
        listener = db.collection("order").addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            do {
                // Mapping der erhaltenen Dokumente zu einer Liste von Bestellungen
                let orders = snapshot.documents.compactMap { queryDocumentSnapshot -> Order? in
                    let data = queryDocumentSnapshot.data()
                    return Order(
                        id: UUID(uuidString: queryDocumentSnapshot.documentID)!,
                        userId: data["userId"] as? String ?? "",
                        userName: data["userName"] as? String ?? "",
                        start: data["start"] as? String ?? "",
                        destination: data["destination"] as? String ?? "",
                        time: data["time"] as? Date ?? Date(),
                        kids: data["kids"] as? Int,
                        luggage: data["luggage"] as? Bool,
                        pets: data["pets"] as? Bool,
                        helpToSitIn: data["helpToSitIn"] as? Bool,
                        passenger: data["passenger"] as? Int,
                        taken: data["taken"] as? Bool ?? false,
                        takenInMin10: data["takenInMin10"] as? Bool ?? false
                    )
                }
                self.orders = orders
            }
        }
    }

    
    func markOrderAsTaken(_ order: Order) {
        if let orderIndex = self.orders.firstIndex(of: order) {
            self.orders[orderIndex].taken.toggle()
            
            let orderRef = db.collection("order").document(order.id.uuidString)
            orderRef.updateData(["taken": self.orders[orderIndex].taken]) { error in
                if let error = error {
                    print("Error updating order: \(error.localizedDescription)")
                    print("Error code: \((error as NSError).code)")
                } else {
                    print("Order updated successfully")
                }
            }
        }
    }
    
    
    func takenInMin10(_ order: Order) {
        if let orderIndex = self.orders.firstIndex(of: order) {
            self.orders[orderIndex].takenInMin10.toggle()
            
            let orderRef = db.collection("order").document(order.id.uuidString)
            orderRef.updateData(["takenInMin10": self.orders[orderIndex].takenInMin10]) { error in
                if let error = error {
                    print("Error updating order: \(error.localizedDescription)")
                    print("Error code: \((error as NSError).code)")
                } else {
                    print("Order updated successfully")
                }
            }
        }
    }
    
    //    func addDriverIdToOrder(_ order: Order, driverId: String) {
    //        if let orderIndex = self.orders.firstIndex(of: order) {
    //            self.orders[orderIndex].driverId = driverId
    //
    //            let orderRef = db.collection("order").document(order.id.uuidString)
    //            orderRef.updateData([
    //                "driverId": driverId
    //            ]) { error in
    //                if let error = error {
    //                    print("Error updating order: \(error.localizedDescription)")
    //                    print("Error code: \((error as NSError).code)")
    //                } else {
    //                    print("Order updated successfully")
    //                }
    //            }
    //        }
    //    }
}

extension Order {
    var asDictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "userId": userId,
            "userName": userName,
            "start": start,
            "destination": destination,
            "time": time,
            "kids": kids ?? 0,
            "luggage": luggage ?? false,
            "pets": pets ?? false,
            "helpToSitIn": helpToSitIn ?? false,
            "passenger": passenger ?? 0,
            "taken": taken,
            "takenInMin10": takenInMin10
        ]
    }
}
