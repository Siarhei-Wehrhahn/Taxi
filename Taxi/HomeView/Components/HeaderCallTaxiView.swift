//
//  HeaderCallTaxiView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 24.02.24.
//

import SwiftUI

struct HeaderCallTaxiView: View {
    @StateObject var viewModel = CallTaxiViewModel()
    
    var body: some View {
        VStack {
            Text("𝑻𝒂𝒙𝒊 𝑨𝒓𝒊𝒇")
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
                    .frame(width: 300, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
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
                    .frame(width: 300, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

#Preview {
    HeaderCallTaxiView()
}
