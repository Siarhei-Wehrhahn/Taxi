//
//  SettingsView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 07.03.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    @State private var profileImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
            } else {
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: $profileImage)
                }
            }
            
            HStack {
                Text("Name:")
                
                Spacer()
                
                Text(viewModel.user?.nickName ?? "Unbekannter Name")
            }
            .padding()
            
            HStack {
                Text("E-Mail")
                
                Spacer()
                
                Text(viewModel.user?.email ?? "Unbekannte E-Mail")
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                Button {
                    
                } label: {
                    Text("Taxi anrufen")
                        .frame(width: 150)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    
                } label: {
                    Text("Support kontaktieren")
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
            
            Button("Abmelden") {
                viewModel.logout()
            }
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationViewModel())
}
