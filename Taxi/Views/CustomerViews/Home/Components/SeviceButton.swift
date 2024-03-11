//
//  Sevicebutton.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 11.03.24.
//

import Foundation
import SwiftUI

class ServiceButton {
    
    
    func serviceButton(label: String, imageName: String, buttonType: String, price: String) -> some View {
            Button {
                self.selectedButton = buttonType
            } label: {
                VStack {
                    Image(imageName)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .shadow(radius: 2)
                    Text(label)
                        .foregroundStyle(.black)
                    Text(price)
                        .font(Font.system(size: 12))
                        .foregroundStyle(.black)
                        .opacity(0.4)
                }
            }
            .padding()
            .background(selectedButton == buttonType ? Color.gray : Color.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 2, x: 2.2, y: 2.2)
            .rotation3DEffect(.degrees(selectedButton == buttonType ? -10 : 0), axis: (x: -1, y: 0, z: 0))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 4)
                    .padding(1)
                    .blur(radius: 5)
                    .mask(selectedButton != buttonType ? RoundedRectangle(cornerRadius: 25)
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [Color.red, Color.clear]),
                                    center: .center,
                                    startRadius: 1,
                                    endRadius: 0 // Adjust this value to control how far the gradient extends from the center to the edges
                                )
                            )
                          : nil)
            )
        }
}
