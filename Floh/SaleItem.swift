//
//  SaleItem.swift
//  Floh
//
//  Created by Abdussamed Sen on 13.01.24.
//

import Foundation

struct SaleItem: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let category: String
    let price: Int
    var imageURL: String?
    
}

extension SaleItem {
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:]}
        return (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
            .flatMap{$0 as? [String: Any]} ?? [:]
    }
}
