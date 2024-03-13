//
//  AuthenticationView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 13.03.24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    @State private var showPasswordAlert = false
    @State private var showEmailAlert = false
    @State private var showNickName = false
    @State private var nicknameOpacity: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.5), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Taxi Taxi")
                    .bold()
                    .foregroundStyle(.yellow)
                    .padding(.bottom, 100)
                    .font(.custom("Script-Regular", size: 50))
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                
                
                TextField("E-Mail", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                
                SecureField("Passwort", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("registrieren") {
                    if viewModel.password.count < 6 {
                        showPasswordAlert = true
                    } else if viewModel.isValidEmail() {
                        viewModel.register()
                    } else {
                        showEmailAlert = true
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .padding()
                .padding(.top)
            }
        }
        .alert(isPresented: $showPasswordAlert) {
            Alert(title: Text("Passwort zu kurz"), message: Text("Das Passwort muss mindestens 6 Zeichen lang sein."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showEmailAlert) {
            Alert(title: Text("Ungültige Email"), message: Text("Gebe bitte eine gültige email adrese an!"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel())
}
