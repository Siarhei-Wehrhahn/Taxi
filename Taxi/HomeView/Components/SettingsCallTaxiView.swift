//
//  SettingsCallTaxiView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import SwiftUI

struct SettingsCallTaxiView: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    @State private var currentTime = Date() // Zustand für die aktuelle Zeit
    
    var body: some View {
        VStack {
            Button {
                viewModel.showSheet.toggle()
            } label: {
                Image(systemName: "slider.vertical.3")
                    .foregroundStyle(.black)
                Text("Details")
                    .foregroundStyle(.black)
                    .padding(.trailing, 250)
            }
            .padding(10)
            .frame(width: 360)
            .background(.lightGray)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 2, x: 2.2, y: 2.2)
            
            HStack {
                Button {
                    // KartenZahlung in Zukunft einbinden
                } label: {
                    Image(systemName: "banknote")
                        .foregroundStyle(.black)
                    Text("In Bar")
                        .foregroundStyle(.black)
                        .padding(.trailing,70)
                }
                .padding(10)
                .frame(width: 175)
                .background(.lightGray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2, x: 2.2, y: 2.2)
                
                Button {
                    viewModel.showDatePicker.toggle()
                } label: {
                    if viewModel.time != currentTime {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundStyle(.black)
                        Text(viewModel.formatDate(viewModel.time))
                            .foregroundStyle(.black)
                    } else {
                        Image(systemName: "clock")
                            .foregroundStyle(.black)
                        Text("Jetzt")
                            .foregroundStyle(.black)
                            .padding(.trailing,70)
                    }
                }
                .padding(10)
                .frame(width: 175)
                .background(.lightGray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2, x: 2.2, y: 2.2)
                
            }
            .sheet(isPresented: $viewModel.showDatePicker) {
                TimePickerSheet()
                    .presentationDetents([.medium, .large])
            }
        }
        .onAppear {
            // Aktuelle Zeit setzen
            if viewModel.time != currentTime {
                viewModel.time = currentTime
            }
        }
    }
}



#Preview {
    SettingsCallTaxiView()
        .environmentObject(CallTaxiViewModel())
}
