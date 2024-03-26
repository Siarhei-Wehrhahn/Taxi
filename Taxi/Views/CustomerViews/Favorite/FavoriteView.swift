//
//  FavoriteView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject private var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject private var callTaxiViewModel: CallTaxiViewModel
    @Binding var selection: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                List(favoriteViewModel.listOfTrips) { trip in
                    VStack {
                        Button {
                            callTaxiViewModel.start = trip.start
                            callTaxiViewModel.destination = trip.destination
                            selection = 0
                        } label: {
                            HStack {
                                Text("von:      \(trip.start) \nnach:    \(trip.destination)")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            // Hier löschen wir den Trip aus der listOfTrips
                            if let index = favoriteViewModel.listOfTrips.firstIndex(of: trip) {
                                favoriteViewModel.listOfTrips.remove(at: index)
                            }
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .navigationTitle("Favoriten")
        .navigationBarTitleDisplayMode(.automatic)
        .sheet(isPresented: $favoriteViewModel.showSheet, content: {
            FavoriteViewSheet()
                .presentationDetents([.medium, .large])
        })
    }
}

#Preview {
    FavoriteView(selection: .constant(2))
        .environmentObject(FavoriteViewModel())
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
