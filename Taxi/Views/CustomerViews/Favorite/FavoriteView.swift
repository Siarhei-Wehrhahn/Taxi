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
    @State private var showSheet = false
    
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
                }
            }
            .navigationTitle("Favoriten")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showSheet, content: {
            FavoriteViewSheet()
                .presentationDetents([.medium, .large])
        })
    }
}

#Preview {
    FavoriteView(selection: .constant(2))
        .environmentObject(FavoriteViewModel())
        .environmentObject(CallTaxiViewModel())
}
