//
//  SettingsView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 07.03.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("E-Mail")
                .frame(width: 320, alignment: .leading)
                .padding()
            Button {
                
            } label: {
                Text("Taxi anrufen")
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                
            } label: {
                Text("Supporter kontaktieren")
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
