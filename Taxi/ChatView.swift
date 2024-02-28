//
//  Historyview.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import SwiftUI

struct ChatView: View {
    @State var chat = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
                .edgesIgnoringSafeArea(.all)
            
            Image(.chatBg)
                .resizable()
                .scaledToFill()
                .padding(.bottom, 50)
            
            Rectangle()
                .foregroundStyle(.lightGray)
                .padding(.top, 630)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                HStack {
                    TextField("Text eingeben", text: $chat)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .frame(width: 300)
                        .padding(.trailing, 10)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(Font.system(size: 25))
                    }
                }
                .padding(.top, 640)
            }
        }
    }
}

#Preview {
    ChatView()
}
