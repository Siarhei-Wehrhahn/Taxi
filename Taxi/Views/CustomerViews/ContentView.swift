//
//  ContentView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var callTaxiViewModel = CallTaxiViewModel()
    @StateObject private var favoriteViewmodel = FavoriteViewModel()
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            CallTaxiView()
                .tabItem {
                    Image(systemName: "car")
                    
                    Text("Bestellung")
                }
                .environmentObject(callTaxiViewModel)
                .tag(0)
            
            ChatView()
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    
                    Text("ChatGPT")
                }
                .tag(1)
            
            FavoriteView(selection: $selection)
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text("Favoriten")
                }
                .environmentObject(favoriteViewmodel)
                .environmentObject(callTaxiViewModel)
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    
                    Text("Einstellungen")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
