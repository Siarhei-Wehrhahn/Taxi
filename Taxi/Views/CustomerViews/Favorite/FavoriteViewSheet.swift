//
//  FavoriteViewSheet.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 10.03.24.
//

import SwiftUI

struct FavoriteViewSheet: View {
    @EnvironmentObject private var viewModel: FavoriteViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "smallcircle.circle")
                        .bold()
                        .foregroundStyle(.yellow)
                        .font(Font.system(size: 30))
                        .padding(.trailing, 7)
                    
                    TextField("Start", text: $viewModel.trip.start)
                        .frame(width: 300)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 0.3)
                        )
                }
                .padding(.top)
                
                HStack {
                    Image(systemName: "record.circle")
                        .bold()
                        .foregroundStyle(.yellow)
                        .font(Font.system(size: 30))
                        .padding(.trailing, 7)
                    
                    TextField("Ziel", text: $viewModel.trip.destination)
                        .frame(width: 300)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 0.3)
                        )
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button("Speichern") {
                viewModel.addTrip()
                dismiss()
                viewModel.trip.start = ""
                viewModel.trip.destination = ""
                print("FavoriteViewSheet: \(viewModel.listOfTrips)")
            })
        }
    }
}

#Preview {
    FavoriteViewSheet()
        .environmentObject(FavoriteViewModel())
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
