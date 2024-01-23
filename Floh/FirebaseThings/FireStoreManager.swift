//
//  FireStoreManger.swift
//  Floh
//
//  Created by Abdussamed Sen on 23.01.24.
//

import Foundation
import SwiftUI
import Firebase

class FireStoreManager: ObservableObject {
    private var storageManager = StorageManager() // Verwenden Sie @StateObject hier
    
    @Published var saleItems: [SaleItem] = []
    
    
    init() {
        fetchAllSaleItems()
    }
    
    func fetchAllSaleItems() {
        let db = Firestore.firestore()
        db.collection("SaleItems").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.saleItems = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: SaleItem.self)
                } ?? []
            }
        }
    }
    
    func fetchAllRestaurants() {
        let db = Firestore.firestore()
        
        db.collection("Restaurants").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID): \(document.data())")
                }
            }
        }
    }
    
    func createSaleItem(_ item: SaleItem, image: UIImage?) {
        if let image = image {
            storageManager.uploadImage(image) { url in
                guard let imageURL = url else {
                    print("Fehler beim Hochladen des Bildes")
                    return
                }
                
                var newItem = item
                newItem.imageURL = imageURL.absoluteString // Fügen Sie die URL zum SaleItem hinzu
                
                let documentId = String(newItem.id)
                
                // Logik, um das newItem in Firestore zu speichern
                let db = Firestore.firestore()
                db.collection("SaleItems").document(documentId).setData(newItem.dictionary) { error in
                    if let error = error {
                        print("Fehler beim Speichern des SaleItem: \(error.localizedDescription)")
                    } else {
                        print("SaleItem erfolgreich gespeichert")
                    }
                }
            }
        }
    }
    
}
