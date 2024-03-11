//
//  Historyview.swift
//  Taxi
//
//  Created by Siarhei Wehrhahn on 26.02.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            // Hintergrund
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
                .edgesIgnoringSafeArea(.all)
            
            // Grauer Balken am unteren Rand
            Rectangle()
                .foregroundStyle(.lightGray)
                .padding(.top, 610)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack {
                List {
                    ForEach(viewModel.messages.indices, id: \.self) { index in
                        if index < viewModel.userMessages.count {
                            Text("Du \n\(viewModel.userMessages[index])")
                            Text("ChatGPT \n\(viewModel.messages[index])")
                                .foregroundStyle(.blue)
                        } else {
                            Text("ChatGPT \n\(viewModel.messages[index])")
                            Text("Du \n\(viewModel.userMessages[index])")
                                .foregroundStyle(.blue)
                        }
                    }
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
                        viewModel.sendMessage()
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
}

#Preview {
    ChatView()
}
