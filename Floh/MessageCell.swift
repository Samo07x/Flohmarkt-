//
//  MessageCell.swift
//  Floh
//
//  Created by Abdussamed Sen on 23.01.24.
//

import SwiftUI

struct MessageCell: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundStyle(isCurrentUser ? .white : .black)
            .background(isCurrentUser ? .blue : .green)
            .clipShape(.rect(cornerRadius: 10))
    }
}
