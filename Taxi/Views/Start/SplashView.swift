//
//  SplashView.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundStyle(LinearGradient(colors: [ .black, .yellow, .gray, .yellow, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
            
            Text("Taxi Taxi")
                .font(Font.system(size: 40))
                .foregroundStyle(.yellow)
                .shadow(radius: 5)
            
        }
    }
}

#Preview {
    SplashView()
}
