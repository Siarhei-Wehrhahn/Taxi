//
//  Taxi_App.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI
import Firebase

@main
struct Taxi_App: App {
    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var orderViewModel = OrderViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if viewRouter.currentPage == .splash {
                    SplashView()
                        .preferredColorScheme(.light) // Deaktiviere den Dark Mode
                        .onAppear {
                            // Nach 2 sek den viewRouter auf HomeView setzen
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewRouter.currentPage = .home
                                }
                            }
                        }
                } else if authenticationViewModel.userIsLoggedIn {
                    UserOrCustomerView()
                        .environmentObject(authenticationViewModel)
                        .environmentObject(orderViewModel)
                        .environmentObject(CallTaxiViewModel(auth: authenticationViewModel))
                } else {
                    RegisterOrLogin()
                        .environmentObject(authenticationViewModel)
                        .preferredColorScheme(.light)
                }
            }
        }
    }
}
