//
//  SettingsView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 07.03.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    @StateObject private var settingsViewModel = SettingsViewModel()
    @State private var isShowingImagePicker = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            if let profileImage = settingsViewModel.profileImage {
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
                    ImagePicker(image: $settingsViewModel.profileImage)
                }
            }
            
            HStack {
                Text("Name:")
                
                Spacer()
                
                Text(authViewModel.user?.nickName ?? "Unbekannter Name")
            }
            .padding()
            
            HStack {
                Text("E-Mail")
                
                Spacer()
                
                Text(authViewModel.user?.email ?? "Unbekannte E-Mail")
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
                if authViewModel.user?.nickName == "Anonym" {
                    authViewModel.deleteAccount()
                    authViewModel.logout()
                } else {
                    authViewModel.logout()
                }
            }
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            .padding(.bottom, 5)
            
            Button("Account löschen") {
                showAlert.toggle()
            }
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            .padding(.bottom, 50)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Account löschen"), message: Text("Bist du sicher, dass du deinen Account löschen möchtest? Alle deine Daten werden dauerhaft gelöscht."), primaryButton: .destructive(Text("Löschen")) {
                    authViewModel.deleteAccount()
                    authViewModel.logout()
                }, secondaryButton: .cancel(Text("Abbrechen")))
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthenticationViewModel())
}
