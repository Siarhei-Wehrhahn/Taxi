//
//  MainView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import SwiftUI

struct MainView: View {
    @State private var isOrdersView = false
    
    var body: some View {
            TabView {
                
                OrdersView()
                    .onAppear {
                        isOrdersView = true
                    }
                    .tabItem {
                        Image(systemName: isOrdersView ? "book" : "book.closed")
                        Text("Aufträge")
                    }
                
                HistoryView()
                    .onAppear {
                        isOrdersView = false
                    }
                    .tabItem {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Verlauf")
                    }
        }
    }
}

#Preview {
    MainView()
}
