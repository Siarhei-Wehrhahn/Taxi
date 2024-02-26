//
//  SettingsCallTaxiView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import SwiftUI

struct SettingsCallTaxiView: View {
    @StateObject var viewModel = CallTaxiViewModel()
    
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
            .frame(width: 365)
            .background(.lightGray)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "banknote")
                        .foregroundStyle(.black)
                    Text("In Bar")
                        .foregroundStyle(.black)
                        .padding(.trailing,70)
                }
                .padding(10)
                .frame(width: 177)
                .background(.lightGray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    
                } label: {
                    Image(systemName: viewModel.time.isEmpty ? "clock" : "calendar.badge.clock")
                        .foregroundStyle(.black)
                    Text(viewModel.time.isEmpty ? "Jetzt" : viewModel.time)
                        .foregroundStyle(.black)
                        .padding(.trailing,70)
                }
                .padding(10)
                .frame(width: 178)
                .background(.lightGray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
}

#Preview {
    SettingsCallTaxiView()
}
