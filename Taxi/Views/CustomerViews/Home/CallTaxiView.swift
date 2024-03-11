//
//  CallTaxiView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//
import SwiftUI
import Combine
import MapKit

struct CallTaxiView: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    @State private var distance: CLLocationDistance = 0.0
    private var price : Double {
        if distance != 0.0 {
            return (Double(distance) / 1000) * 2.6 + (viewModel.checkWhichTaxi())
        } else {
            return 0.0
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HeaderCallTaxiView()

                    MapView(startCoordinate: $viewModel.startCoordinate, endCoordinate: $viewModel.endCoordinate, distance: $distance)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .padding()
                        .shadow(radius: 2, x: 2.2, y: 2.2)
                        .scaleEffect(CGSize(width: 1.0, height: 1.0))

                    SettingsCallTaxiView()

                    ServiceRowView()
                        .padding()

                    if viewModel.selectedButton == nil {
                        Text("Fülle bitte die nötigen Informationen aus!")
                        
                    } else {
                        Button {
                            // Hier die Bestellaktion einfügen
                        } label: {
                            Text("Für ca \(String(format: "%.2f", price))€ bestellen")
                                .foregroundStyle(.black)
                        }
                        .padding(10)
                        .frame(width: 350)
                        .background(.lightGray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 2, x: 2.2, y: 2.2)
                    }
                }
                .sheet(isPresented: $viewModel.showSheet) {
                    CallTaxiDetailSheetView()
                        .presentationDetents([.medium, .large])
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CallTaxiView()
        .environmentObject(CallTaxiViewModel())
}
