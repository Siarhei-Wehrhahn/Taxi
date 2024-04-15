//
//  MainView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: OrderViewModel
    @State private var isOrdersView = false
    
    var body: some View {
        TabView {
            OrdersView()
                .onAppear {
                    isOrdersView = true
                    print("\(viewModel.orders.count)")
                }
                .tabItem {
                    Image(systemName: isOrdersView ? "book.fill" : "book.closed.fill")
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
        .environmentObject(OrderViewModel())
}
