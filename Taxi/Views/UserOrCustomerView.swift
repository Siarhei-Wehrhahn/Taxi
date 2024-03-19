//
//  UserOrCustomerView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 15.03.24.
//

import SwiftUI

struct UserOrCustomerView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    
    var body: some View {
        if ((viewModel.user?.driver) != nil && viewModel.user!.driver) {
            MainView()
        } else {
            ContentView()
        }
    }
}

#Preview {
    UserOrCustomerView()
        .environmentObject(AuthenticationViewModel())
}
