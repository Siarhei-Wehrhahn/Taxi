//
//  CallTaxiView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI
import MapKit

struct CallTaxiView: View {
    @StateObject var viewModel = CallTaxiViewModel
    
    var body: some View {
        VStack {
            
            HeaderCallTaxiView()
            
            Map()
                .frame(width: 365, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding()
            
            SettingsCallTaxiView()
            
            ServiceRowView()
                .padding()
            Spacer()
        }
        .sheet(isPresented: $viewModel.showSheet) {
            CallTaxiDetailView()
        }
    }
}

#Preview {
    CallTaxiView()
}
