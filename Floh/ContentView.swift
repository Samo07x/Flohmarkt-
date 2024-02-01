//
//  ContentView.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fireStoreManager: FireStoreManager
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
        var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PlaceholderView()
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            NewAdView()
                .tabItem {
                    Label("Sale Item", systemImage: "plus.square.on.square")
                }

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FireStoreManager())
}
