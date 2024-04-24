//
//  CallTaxiView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 22.02.24.
//
import SwiftUI
import Combine
import MapKit

struct CallTaxiView: View {
    @EnvironmentObject var viewModel: CallTaxiViewModel
    @State private var distance: CLLocationDistance = 0.0
    private var price : Double {
        if distance != 0.0 {
            return (Double(distance) / 1000) * 2.6 + (viewModel.checkWhichTaxi())
        } else {
            return 0.0
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack {
                HeaderCallTaxiView()
                
                MapView(startCoordinate: $viewModel.startCoordinate,
                        endCoordinate: $viewModel.endCoordinate,
                        distance: $distance)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding()
                .shadow(radius: 2, x: 2.2, y: 2.2)
                .scaleEffect(CGSize(width: 1.0, height: 1.0))
                
                SettingsCallTaxiView()
                
                ServiceRowView()
                    .padding()
                
                if viewModel.selectedButton == nil {
                    Text("Fülle bitte die nötigen Informationen aus!")
                    
                } else {
                    Button {
                        viewModel.createOrder()
                        viewModel.showToast.toggle()
                    } label: {
                        Text("Für ca \(String(format: "%.2f", price))€ bestellen")
                            .foregroundStyle(.black)
                    }
                    .padding(10)
                    .frame(width: 350)
                    .background(.lightGray)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 2, x: 2.2, y: 2.2)
                    .toast(message: "Erfolgreich bestellt!", isPresented: $viewModel.showToast)
                    
                    
                }
            }
            .sheet(isPresented: $viewModel.showSheet) {
                CallTaxiDetailSheetView()
                    .presentationDetents([.medium, .large])
            }
            .alert(isPresented: Binding<Bool>.constant(viewModel.showTakenAlert || viewModel.showTakenLaterAlert)) {
                let message: String
                let title: String
                let dismissButtonTitle: String
                let dismissAction: () -> Void
                
                if viewModel.showTakenAlert {
                    title = "Angenommen!"
                    message = "Deine Fahrt wurde angenommen! Dein Fahrer wird so schnell wie möglich bei dir sein."
                    dismissButtonTitle = "OK!"
                    dismissAction = { viewModel.showTakenAlert = false }
                } else if viewModel.showTakenLaterAlert {
                    title = "Angenommen in 10 Minuten"
                    message = "Deine Fahrt wird in 10 Minuten angenommen!"
                    dismissButtonTitle = "OK!"
                    dismissAction = { viewModel.showTakenLaterAlert = false }
                } else {
                    title = ""
                    message = ""
                    dismissButtonTitle = ""
                    dismissAction = {}
                }
                
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text(dismissButtonTitle), action: dismissAction)
                )
            }
        }
    }
}

extension View {
    func toast(message: String, isPresented: Binding<Bool>) -> some View {
        self.overlay(
            ZStack {
                if isPresented.wrappedValue {
                    ToastView(message: message)
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            withAnimation {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isPresented.wrappedValue = false
                                }
                            }
                        }
                }
            }
        )
    }
}




#Preview {
    CallTaxiView()
        .environmentObject(CallTaxiViewModel(auth: AuthenticationViewModel()))
}
