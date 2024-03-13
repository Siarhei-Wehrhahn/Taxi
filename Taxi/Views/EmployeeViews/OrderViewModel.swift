//
//  OrderViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [OrderModel] = []
}

// TODO die verbindung zwischen bei den viewModels herstellen und mit einer func die liste befüllen
// dabei sollen alle atribute ausgefüllt werden die gesucht werden 
