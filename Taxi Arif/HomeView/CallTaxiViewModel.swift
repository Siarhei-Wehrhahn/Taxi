//
//  CallTaxiViewModel.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import Foundation

class CallTaxiViewModel: ObservableObject {
    @Published var showSheet: Bool = false
    @Published var time = ""
    @Published var start = ""
    @Published var destination = ""
}
