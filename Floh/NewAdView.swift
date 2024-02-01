//
//  NewAdView.swift
//  Floh
//
//  Created by Abdussamed Sen on 25.01.24.
//
import PhotosUI
import SwiftUI

struct NewAdView: View {
    var storageManager = StorageManager()
    @StateObject var firestoreManager = FireStoreManager() // FirestoreManager Instanz
    
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var avatarUIImage: UIImage? // Speichern des UIImage
    @State private var name = ""
    @State private var description = ""
    @State private var price = 0
    @State private var selectedCategory = "Electronic"
    let strengths = ["Electronic", "Car", "Fashion", "Others"]
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView{
                VStack {
                    avatarImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    PhotosPicker("Select Image to Upload", selection: $avatarItem, matching: .images)
                    
                    
                }
                .onChange(of: avatarItem) {
                    Task {
                        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                self.avatarUIImage = uiImage
                                self.avatarImage = Image(uiImage: uiImage)
                            }
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
                
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.secondary)
                    .padding(.vertical)
                
                Section(header: Text("Describe your Item")) {
                    VStack {
                        TextField("Item Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .padding(8)
                        
                        
                        TextField("Enter your Price", value: $price, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        HStack{
                            Section(header: Text("Select your Category")){
                                Picker("Strength", selection: $selectedCategory) {
                                    ForEach(strengths, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                        }
                        
                        TextField("Describe your Item", text: $description)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                    }
                    
                    .navigationTitle("New Item")
                }
            }
            Button("Send") {
                let newSaleItem = SaleItem(id: Int.random(in: 1...9999),
                                           name: name,
                                           description: description, // Ersetzen Sie dies durch eine tatsächliche Beschreibung
                                           category: selectedCategory,
                                           price: price,
                                           imageURL: "") // Hier können Sie 'nil' setzen, da das Bild später hinzugefügt wird

                // Überprüfen Sie, ob ein Bild vorhanden ist, und rufen Sie dann createSaleItem auf
                if let uiImage = avatarUIImage {
                    firestoreManager.createSaleItem(newSaleItem, image: uiImage) // Entfernen Sie das 'item:' Label
                } else {
                    // Fügen Sie hier eine Logik hinzu, wenn kein Bild ausgewählt wurde
                    firestoreManager.createSaleItem(newSaleItem, image: nil) // Entfernen Sie das 'item:' Label
                }

                print("SaleItem gespeichert:", newSaleItem)
            }

            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(8)
            
        }
    }
}

#Preview {
    NewAdView()
}
