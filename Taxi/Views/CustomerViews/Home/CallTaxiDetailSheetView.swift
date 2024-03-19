//
//  CallTaxiDetailView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

struct CallTaxiDetailSheetView: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Toggle(isOn: $viewModel.isCheating) {
                        Text("Kinder")
                    }
                    
                    if viewModel.isCheating {
                        PickerView(selectedNumber: $viewModel.children)
                    }
                    
                    Divider()
                    
                    Toggle("Gepäck", isOn: $viewModel.luggage)
                    
                    Divider()
                    
                    Toggle("Haustiere", isOn: $viewModel.pets)
                    
                    Divider()
                    
                    Toggle("Hilfe beim einsteigen", isOn: $viewModel.helpToSitIn)
                    
                    Divider()
                    
                    TextField("Passagiere", text: $viewModel.numberOfPassager)
                }
            }
            .navigationBarItems(trailing:
                Button("Speichern") {
                    dismiss()
                }
            )
        }
    }
}


#Preview {
    CallTaxiDetailSheetView()
        .environmentObject(CallTaxiViewModel())
}
