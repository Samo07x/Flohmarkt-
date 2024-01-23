//
//  SearchResultsView.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//

import SwiftUI

struct SearchResultsView: View {
    let items: [SaleItem]
    
    var body: some View {
        List(items, id: \.id) { item in
            NavigationLink(destination: AdView(item: item)) {
                VStack(alignment:.leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("\(item.price) €")
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle("Suchergebnisse")
    }
}
