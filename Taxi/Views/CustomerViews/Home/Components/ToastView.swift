//
//  ToastView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 09.04.24.
//

import SwiftUI

struct ToastView: View {
    @EnvironmentObject private var viewModel: CallTaxiViewModel
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            viewModel.showToast = false
                        }
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    ToastView(message: "Erfolgreich Bbstellt")
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
