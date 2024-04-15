//
//  OrdersView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import SwiftUI

// Umkreis von *** die fahrten anzeigen lassen mit snapshotlistener

struct OrdersView: View {
    @EnvironmentObject private var viewModel: OrderViewModel
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                if authViewModel.isUserAvailable {
                    ForEach(viewModel.orders) { order in
                        
                        VStack {
                            
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("Name: \(order.userName)")
                                    Text("Start: \(order.start)")
                                    Text("Ziel: \(order.destination)")
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    if order.kids != nil {
                                        Text("Kinder:   \(order.kids != nil ? String(order.kids!) : "-")")
                                    }
                                    
                                    if order.luggage != nil {
                                        Text("Gepäck:  \(order.luggage != nil ? (order.luggage! ? "ja" : "nein") : "-")")
                                    }
                                    
                                    if order.pets != nil {
                                        Text("Haustier:  \(order.pets != nil ? (order.pets! ? "ja" : "nein") : "-")")
                                    }
                                    
                                    HStack {
                                        
                                        if order.helpToSitIn != nil {
                                            Text("einstiegshilfe:")
                                            Text("\(order.helpToSitIn != nil ? (order.helpToSitIn! ? "ja" : "nein") : "-")")
                                                .lineLimit(2)
                                        }
                                    }
                                    
                                    if order.passenger != nil {
                                        Text("Passagiere:   \(order.passenger != nil ? String(order.passenger!) : "-")")
                                    }
                                }
                            }
                            .padding(.bottom)
                            
                            HStack(spacing: 33) {
                                
                                if order.taken || order.takenInMin10 {
                                    Button {
                                        viewModel.addOrderToDrivenOrders(order: order)
                                    } label: {
                                        Text("Fahrt beendet")
                                    }
                                    .buttonStyle(BorderedProminentButtonStyle())
                                }
                                
                                if !order.takenInMin10 {
                                    Button {
                                        viewModel.markOrderAsTaken(order)
                                    } label: {
                                        Text(order.taken ? "Abbrechen" : "Annehmen")
                                    }
                                    .buttonStyle(BorderedProminentButtonStyle())
                                }
                                
                                if !order.taken {
                                    Button {
                                        viewModel.takenInMin10(order)
                                    } label: {
                                        Text(order.takenInMin10 ? "Abbrechen" : "In 10min Annehmen")
                                    }
                                    .buttonStyle(BorderedProminentButtonStyle())
                                }
                                
                                if !order.taken && !order.takenInMin10 {
                                    Button {
                                        authViewModel.temporarilySetUnavailableForTenMinutes()
                                    } label: {
                                        Text("Besetzt")
                                    }
                                    .buttonStyle(BorderedProminentButtonStyle())
                                }
                            }
                            
                            Divider()
                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    OrdersView()
        .environmentObject(AuthenticationViewModel())
        .environmentObject(OrderViewModel())
}
