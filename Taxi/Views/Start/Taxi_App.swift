//
//  Taxi_ArifApp.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

@main
struct Taxi_App: App {
    @StateObject private var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
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
                } else if viewRouter.currentPage == .home {
                    ContentView()
                        .preferredColorScheme(.light) 
                }
            }
        }
    }
}