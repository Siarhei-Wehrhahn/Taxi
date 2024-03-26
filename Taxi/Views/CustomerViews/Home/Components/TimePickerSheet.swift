//
//  TimePickerSheet.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import SwiftUI

struct TimePickerSheet: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            DatePicker("", selection: $viewModel.time)
            .datePickerStyle(.wheel)
            .padding(.trailing, 38)
            
            
            Button("Speichern") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    TimePickerSheet()
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
