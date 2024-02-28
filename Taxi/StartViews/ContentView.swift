//
//  ContentView.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CallTaxiViewModel()
    
    var body: some View {
        TabView {
            CallTaxiView()
                .tabItem {
                    Image(systemName: "car")
                }
                .environmentObject(viewModel)
            
            ChatView()
                .tabItem {
                    Image(systemName: "books.vertical")
                }
        }
    }
}

#Preview {
    ContentView()
}
