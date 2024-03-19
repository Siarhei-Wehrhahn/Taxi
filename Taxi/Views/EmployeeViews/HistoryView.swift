//
//  HistoryView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Abmelden") {
                viewModel.logout()
            }
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            .padding(.bottom, 5)
        }
        // Eine liste mahcen mit dem aus dem viewModel bereit gestellten daten
        // Sobald abgelehnt wird soll die fart für einen fahrer nicht mwhr sichtbar sein und wenn er angenommen wird für alle anderen unsichtbar
    }
}

#Preview {
    HistoryView()
        .environmentObject(AuthenticationViewModel())
}
