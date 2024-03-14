//
//  RegisterOrLogin.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 14.03.24.
//

import SwiftUI

struct RegisterOrLogin: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        if viewModel.showRegister {
            AuthenticationView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RegisterOrLogin()
}
