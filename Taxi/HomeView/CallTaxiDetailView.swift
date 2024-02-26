//
//  CallTaxiDetailView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

struct CallTaxiDetailView: View {
    @State private var isCheating = false
    @State var children = 0
    @State var luggage = false
    @State var bigTaxi = false
    @State var pets = false
    @State var helpToSitIn = false
    @State var numberOfPassager = ""
    
    var body: some View {
        Form {
            VStack {
                Toggle(isOn: $isCheating) {
                    Text("Kinder")
                }
                
                if isCheating {
                    PickerView(selectedNumber: $children)
                }
                
                Divider()
                
                Toggle("Gepäck", isOn: $luggage)
                
                Divider()
                
                Toggle("Großraumtaxi", isOn: $bigTaxi)
                
                Divider()
                
                Toggle("Haustiere", isOn: $pets)
                
                Divider()
                
                Toggle("Hilfe beim einsteigen", isOn: $helpToSitIn)
                
                Divider()
                
                TextField("Passagiere", text: $numberOfPassager)
            }
        }
    }
}


#Preview {
    CallTaxiDetailView()
}
