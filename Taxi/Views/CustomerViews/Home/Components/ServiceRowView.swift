//
//  ServiceRowView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 23.02.24.
//

import SwiftUI

struct ServiceRowView: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    // stoke mit lineargradient
    var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    viewModel.serviceButton(label: "Normales Taxi", imageName: "taxi", buttonType: "taxi", price: "4,00")
                    viewModel.serviceButton(label: "Großraum Taxi", imageName: "bigTaxi", buttonType: "bigTaxi", price: "5,00")
                    viewModel.serviceButton(label: "Lieferfahrt", imageName: "delivery", buttonType: "delivery", price: "5,00")
                    viewModel.serviceButton(label: "ServiceFahrt", imageName: "service", buttonType: "service", price: "5,00")
                }
                .frame(width: 555,height: 150)
            }
        }
    }

#Preview {
    ServiceRowView()
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
