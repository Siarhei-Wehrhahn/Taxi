//
//  Historyview.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var messageText = ""

    var body: some View {
        ZStack {
            // Hintergrund
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
                .edgesIgnoringSafeArea(.all)
            
            // Hintergrundbild
//            Image("chatBg")
//                .resizable()
//                .scaledToFill()
//                .padding(.bottom, 50)
            
            // Grauer Balken am unteren Rand
            Rectangle()
                .foregroundStyle(.lightGray)
                .padding(.top, 630)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                // Nachrichtenliste
                List(viewModel.messages, id: \.self) { message in
                    Text("\(message)")
                }
                .padding(.top, 20)
                
                // Eingabefeld und Senden-Button
                HStack {
                    TextField("Nachricht eingeben", text: $viewModel.userInput)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                        .frame(width: 300)
                        .padding(.trailing, 10)
                    
                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(Font.system(size: 25))
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        }
    }

    private func sendMessage() {
        viewModel.sendMessage(text: messageText)
    }
}

#Preview {
    ChatView()
}
