//
//  Taxi_ArifApp.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI
import Firebase

@main
struct Taxi_App: App {
    @StateObject private var viewRouter = ViewRouter()
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
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
                    ContentView()
                        .environmentObject(authenticationViewModel)
                } else {
                    RegisterOrLogin()
                        .environmentObject(authenticationViewModel)
                        .preferredColorScheme(.light)
                }
            }
        }
    }
}
