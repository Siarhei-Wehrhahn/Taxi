//
//  AuthenticationView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 13.03.24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    @State private var nicknameOpacity: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.5), Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button {
                    viewModel.showRegister = false
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 20))
                }
                .offset(CGSize(width: -170.0, height: -130.0))
                
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
                        viewModel.showPasswordAlert = true
                    } else {
                        viewModel.register()
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .padding()
                .padding(.top)
                
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Anmeldedaten falsch!"), message: Text("Die E-Mail adresse oder das passwort ist leider falsch."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("E-Mail Vorhanden"), message: Text("Die eingegebene E-Mail-Adresse ist bereits registriert. Bitte verwenden Sie diese, um sich einzuloggen."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $viewModel.showPasswordAlert) {
            Alert(title: Text("Passwort zu kurz"), message: Text("Das Passwort muss mindestens 6 Zeichen lang sein."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $viewModel.showEmailAlert) {
            Alert(title: Text("Ungültige Email"), message: Text("Gebe bitte eine gültige email adrese an!"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel())
}
