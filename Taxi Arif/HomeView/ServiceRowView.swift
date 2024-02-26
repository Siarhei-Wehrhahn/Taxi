//
//  ServiceRowView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 23.02.24.
//

import SwiftUI

struct ServiceRowView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    
                } label: {
                    VStack {
                        Image(.taxi)
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("Normales Taxi")
                            .foregroundStyle(.black)
                        Text("Ab 3,50€")
                            .font(Font.system(size: 12))
                            .foregroundStyle(.black)
                            .opacity(0.4)
                    }
                }
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button {
                    
                } label: {
                    VStack {
                        Image(.bigTaxi)
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("Großraum Taxi")
                            .foregroundStyle(.black)
                        Text("Ab 5€")
                            .font(Font.system(size: 12))
                            .foregroundStyle(.black)
                            .opacity(0.4)
                    }
                }
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button {
                    
                } label: {
                    VStack {
                        Image(.delivery)
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("Lieferfahrt")
                            .foregroundStyle(.black)
                        Text("Ab 5€")
                            .font(Font.system(size: 12))
                            .foregroundStyle(.black)
                            .opacity(0.4)
                    }
                }
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button {
                    
                } label: {
                    VStack {
                        Image(.service)
                            .resizable()
                            .frame(width: 55, height: 55)
                        Text("ServiceFahrt")
                            .foregroundStyle(.black)
                        Text("Ab 5€")
                            .font(Font.system(size: 12))
                            .foregroundStyle(.black)
                            .opacity(0.4)
                    }
                }
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
    }
}

#Preview {
    ServiceRowView()
}
