//
//  CallTaxiViewModel.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import Foundation
import MapKit
import Combine
import SwiftUI

class CallTaxiViewModel: ObservableObject {
    @Published var order: [Order] = []
    @Published var showSheet: Bool = false
    @Published var time = Date()
    @Published var start = ""
    @Published var destination = ""
    @Published var showDatePicker = false
    
    @Published var isCheating = false
    @Published var children = 0
    @Published var luggage = false
    @Published var pets = false
    @Published var helpToSitIn = false
    @Published var numberOfPassager = ""
    
    @Published var selectedButton: String?
    
    @Published var startCoordinate: CLLocationCoordinate2D?
    @Published var endCoordinate: CLLocationCoordinate2D?
    private var subscriptions = Set<AnyCancellable>()
    
    private var auth = AuthenticationViewModel()
    
    init() {
        $start.debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.geocodeAddress(address: t, completion: {coordinate in
                    self?.startCoordinate = coordinate
                })
            } )
            .store(in: &subscriptions)
        
        $destination.debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.geocodeAddress(address: t, completion: {coordinate in
                    self?.endCoordinate = coordinate
                })
            } )
            .store(in: &subscriptions)
    }
    
    func createOrder() {
        let order = Order(id: UUID(), userName: auth.user!.nickName, start: self.start, destination: self.destination, time: self.time, kids: self.children, luggage: self.luggage, pets: self.pets, helpToSitIn: self.helpToSitIn, passenger: Int(self.numberOfPassager), taken: false, takenInMin10: false)
        
        do {
            try FirebaseManager.shared.fireStore.collection("order").document().setData(from: order)
            self.order.append(order)
        } catch {
            print("Could not create user: \(error)")
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, HH:mm' Uhr'"
        return formatter.string(from: date)
    }
    
    func geocodeAddress(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                print("Geocoding error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            completion(placemark.location?.coordinate)
        }
    }
    
    func checkWhichTaxi() -> Double{
        if selectedButton == "taxi" {
            return 4.0
        } else if selectedButton == "bigTaxi" {
            return 5.0
        } else if selectedButton == "delivery" {
            return 5.0
        } else if selectedButton == "service" {
            return 5.0
        } else {
            return 3.5
        }
    }
    
    func serviceButton(label: String, imageName: String, buttonType: String, price: String) -> some View {
            Button {
                self.selectedButton = buttonType
            } label: {
                VStack {
                    Image(imageName)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .shadow(radius: 2)
                    Text(label)
                        .foregroundStyle(.black)
                    Text(price)
                        .font(Font.system(size: 12))
                        .foregroundStyle(.black)
                        .opacity(0.4)
                }
            }
            .padding()
            .background(selectedButton == buttonType ? Color.gray : Color.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 2, x: 2.2, y: 2.2)
            .rotation3DEffect(.degrees(selectedButton == buttonType ? -10 : 0), axis: (x: -1, y: 0, z: 0))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 4)
                    .padding(1)
                    .blur(radius: 5)
                    .mask(selectedButton != buttonType ? RoundedRectangle(cornerRadius: 25)
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [Color.red, Color.clear]),
                                    center: .center,
                                    startRadius: 1,
                                    endRadius: 0 // Adjust this value to control how far the gradient extends from the center to the edges
                                )
                            )
                          : nil)
            )
        }
}
