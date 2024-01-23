//
//  PlaceholderView.swift
//  Floh
//
//  Created by Abdussamed Sen on 23.01.24.
//

import SwiftUI

struct PlaceholderView: View {
    @EnvironmentObject var firestoreManager: FireStoreManager
    
    
    var body: some View {
        Text("this")
    }
}

#Preview {
    PlaceholderView()
        .environmentObject(FireStoreManager())
}
