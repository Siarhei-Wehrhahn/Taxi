//
//  ContentView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI
struct ContentView: View {
    @StateObject private var callTaxiViewModel = CallTaxiViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    @State var selection = 0
    
    var body: some View {
        NavigationStack {
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
                    .environmentObject(favoriteViewModel)
                    .environmentObject(callTaxiViewModel)
                    .tag(2)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Einstellungen")
                    }
                    .tag(3)
            }
            .navigationBarItems(trailing: Group {
                if selection == 2 {
                    HStack {
                        Button {
                            favoriteViewModel.showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        Button {
                            favoriteViewModel.deleteAll()
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            })
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(CallTaxiViewModel())
        .environmentObject(FavoriteViewModel())
}
