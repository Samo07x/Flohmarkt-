//
//  HomeView.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//

import SwiftUI
import FirebaseDatabaseInternal

struct HomeView: View {
    @StateObject var firestoreManager = FireStoreManager() // Verwenden Sie @StateObject hier
    
    
    @State private var searchText = ""
    @State private var showSearchResults = false
    
    
    
    let realItems: () = FireStoreManager().fetchAllRestaurants()
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var filteredItems: [SaleItem] {
        if searchText.isEmpty {
            return firestoreManager.saleItems
        } else {
            return firestoreManager.saleItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if !searchText.isEmpty {
                    SearchResultsView(items: filteredItems)
                } else {
                    LazyVGrid(columns:columns) {
                        ForEach(firestoreManager.saleItems) { item in
                            NavigationLink {
                                AdView(item: item)
                            } label: {
                                VStack{
                                    AsyncImage(url: URL(string: item.imageURL)) { image in
                                        image.resizable()
                                            .frame(width: 120, height: 70)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    VStack{
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        HStack{
                                            
                                            Text("\(item.price) €")
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                            
                                            Text("   Ort")
                                                .font(.caption2)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(.rect(cornerRadius:10))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                                )
                            }}
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .searchable(text: $searchText) {
                ForEach(filteredItems) { item in
                    NavigationLink(destination: AdView(item: item)) {
                        /*@START_MENU_TOKEN@*/Text(item.name)/*@END_MENU_TOKEN@*/
                    }
                    
                }
            }
            .navigationTitle("Flohmarkt")
            .background(.darkBackground)
            .preferredColorScheme(.dark
            )
        }
        .onAppear{
            firestoreManager.fetchAllSaleItems() // Rufen Sie fetchAllSaleItems auf der @StateObject Instanz auf
            
        }
    }
}

#Preview {
    HomeView()
}
