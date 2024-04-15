//
//  HistoryView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var viewModel: AuthenticationViewModel
    @EnvironmentObject private var orderViewModel: OrderViewModel

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm' Uhr'"
        return formatter
    }

    var body: some View {
        VStack {
            List {
                ForEach(orderViewModel.drivenOrders) { order in
                    VStack(alignment: .leading) {
                        if orderViewModel.shouldShowDateSeparator(for: order) {
                            Section(header: Text(dateFormatter.string(from: order.time)).foregroundColor(.black)) {
                                OrderRow(order: order)
                            }
                        } else {
                            OrderRow(order: order)
                        }
                    }
                    .padding()
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteOrderFromDrivenOrders(orderID: order.id)
                        } label: {
                            Label("Löschen", systemImage: "trash")
                        }
                    }
                }
            }
            Spacer()
            Button("Abmelden") {
                viewModel.logout()
            }
            .frame(width: 300, height: 40)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 7.0))
            .padding(.bottom, 5)
        }
        .onAppear {
            orderViewModel.fetchData()
        }
    }

    private func OrderRow(order: Order) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Von:")
                    Text(order.start)
                }
                HStack {
                    Text("Nach:")
                    Text(order.destination)
                }
            }
            Spacer()
            VStack {
                Text("Wann:")
                Text(timeFormatter.string(from: order.time))
            }
        }
    }
}



//#Preview {
//    HistoryView()
//        .environmentObject(AuthenticationViewModel())
//}
