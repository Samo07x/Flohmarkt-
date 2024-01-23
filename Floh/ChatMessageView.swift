//
//  ChatMessageView.swift
//  Floh
//
//  Created by Abdussamed Sen on 23.01.24.
//
import Combine
import SwiftUI

struct ChatMessageView: View {
    @State var messages = DataSource.messages
    @State private var newMessage = ""
    
    var body: some View {
        
            VStack {
                ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    Button(action: sendMessage)   {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
        
        
        
    }
    func sendMessage() {
        
        if !newMessage.isEmpty{
            messages.append(Message(content: newMessage, isCurrentUser: true))
            messages.append(Message(content:"Reply of" + newMessage, isCurrentUser: false))
            newMessage = ""
        }
    }
}

#Preview {
    ChatMessageView()
}
