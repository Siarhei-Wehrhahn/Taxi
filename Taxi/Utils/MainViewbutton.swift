//
//  MainViewbutton.swift
//  Taxi Arif
//
//  Created by Siarhei Wehrhahn on 23.02.24.
//

import SwiftUI

struct MainViewbutton<Content: View>: View {
    let action: () -> Void
    let content: Content
    let width: CGFloat
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content, width: CGFloat) {
        self.content = content()
        self.action = action
        self.width = width
    }
    
    var body: some View {
        Button(action: action) {
            content
                .padding(10)
                .frame(width: width)
                .background(Color.lightGray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
