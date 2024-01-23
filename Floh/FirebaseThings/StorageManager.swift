//
//  StorageManager.swift
//  Floh
//
//  Created by Abdussamed Sen on 25.01.24.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

public class StorageManager: ObservableObject {
    let storage = Storage.storage()
    
    
    
    
    func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Fehler beim Konvertieren des Bildes in Daten")
            return
        }
        // Local file you want to upload
        let localFile = URL(string: "path/to/image")!
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        let imageName = UUID().uuidString + ".jpg"
        let storageRef = storage.reference().child("images/\(imageName)")
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = storageRef.putData(imageData, metadata: metadata)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }
        
        uploadTask.observe(.success) { snapshot in
                // Bild erfolgreich hochgeladen, URL abrufen
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Fehler beim Abrufen der URL: \(error.localizedDescription)")
                        completion(nil)
                    } else {
                        completion(url) // URL des hochgeladenen Bildes zurückgeben
                    }
                }
            }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
            completion(nil)

        }
        
        
    }
    
    func listAllFiles() {
        let storageRef = storage.reference().child("images")
        storageRef.listAll{(result, error) in
            if let error = error {
                print("Error while listing all files", error)
            }
            for item in result!.items{
                print("item in images folder", item)
            }
        }
    }
    
    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (Result<StorageListResult, Error>) -> Void = { result in
            switch result {
            case .success(let listResult):
                for item in listResult.items {
                    print("item: ", item) // Returns an array of items
                }
            case .failure(let error):
                print("error", error)
            }
        }
        
        // List the items
        storageRef.list(maxResults: 1, completion: handler)
    }
    
    func deleteItem(item: StorageReference) {
        item.delete{error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}

