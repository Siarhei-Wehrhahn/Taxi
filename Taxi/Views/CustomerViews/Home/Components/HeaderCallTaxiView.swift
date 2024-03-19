//
//  HeaderCallTaxiView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import SwiftUI

struct HeaderCallTaxiView: View {
    @EnvironmentObject var viewModel : CallTaxiViewModel
    @FocusState var isFocused : Bool
    
    var body: some View {
        VStack {
            Text("𝑻𝒂𝒙𝒊")
                .font(Font.system(size: 20))
                .padding(.trailing, 250)
            
            HStack {
                Image(systemName: "smallcircle.circle")
                    .bold()
                    .foregroundStyle(.yellow)
                    .font(Font.system(size: 30))
                    .padding(.trailing, 7)
                
                TextField("𝑾𝒐 𝒔𝒐𝒍𝒍𝒆𝒏 𝒘𝒊𝒓 𝒅𝒊𝒄𝒉 𝒂𝒃𝒉𝒐𝒍𝒆𝒏?", text: $viewModel.start)
                    .padding()
                    .background(.lightGray)
                    .frame(width: 310, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 4, x: 2.2, y: 2.2)
            }
            
            HStack {
                Image(systemName: "record.circle")
                    .bold()
                    .foregroundStyle(.yellow)
                    .font(Font.system(size: 30))
                    .padding(.trailing, 7)
                
                TextField("𝑾𝒐 𝒎ö𝒄𝒉𝒕𝒆𝒔𝒕 𝒅𝒖 𝒉𝒊𝒏?", text: $viewModel.destination)
                    .padding()
                    .background(.lightGray)
                    .frame(width: 310, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 4, x: 2.2, y: 2.2)
            }
        }
    }
}

#Preview {
    HeaderCallTaxiView()
        .environmentObject(CallTaxiViewModel())
}
