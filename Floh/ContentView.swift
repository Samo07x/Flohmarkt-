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
    
    let testItem = SaleItem(id: 1, name: "Beispielartikel", description: "Beschreibung", category: "Kategorie", price: 100)

    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AdView(item: testItem)
                .tabItem {
                    Label("Ads", systemImage: "macmini")
                }
            PlaceholderView()
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            NewAdView()
                .tabItem {
                    Label("Insert", systemImage: "circle")
                }

        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FireStoreManager())
}
