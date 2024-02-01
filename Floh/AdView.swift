//
//  AdView.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//

import SwiftUI

struct AdView: View {
    let item: SaleItem
    @State private var navigated = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary)
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Section {
                        HStack{
                            Text("\(item.price) €")
                                .font(.headline)
                            Spacer()
                            Text("Kategorie: \(item.category)")
                                .padding(.vertical)
                        }
                        
                    }
                    Text("Beschreibung:")
                        .font(.subheadline)
                        .padding(.top, 5)
                    
                    Text(item.description)
                        .padding(.bottom, 5)
                    
                    
                }
                .padding(.horizontal)
                
                
                
            }
            .padding(.bottom)
            
                .safeAreaInset(edge: .bottom, spacing: 20) {
                    
                    NavigationLink("New Message", destination: ChatMessageView(), isActive: $navigated)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.green)
                    .cornerRadius(8)
                }
                .padding()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    AdView(item: SaleItem(id: 1, name: "Beispielartikel", description: "Dies ist eine detaillierte Beschreibung des Artikels.", category: "Kategorie", price: 100, imageURL: "testamk"))
}
