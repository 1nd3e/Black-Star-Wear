//
//  Products.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import Foundation

struct ProductsItem {
    
    // MARK: - Properties
    
    let name: String
    let description: String
    let price: String
    let thumbImageUrl: String
    let productImages: Array<[String: Any]>
    let sortOrder: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let name = data["name"] as? String,
            let description = data["description"] as? String,
            let price = data["price"] as? String,
            let thumbImageUrl = data["mainImage"] as? String,
            let productImages = data["productImages"] as? Array<[String: Any]>, productImages.count > 0,
            let sortOrder = data["sortOrder"] as? String
        else {
            return nil
        }
        
        self.name = name
        self.description = description
        self.price = price
        self.thumbImageUrl = thumbImageUrl
        self.productImages = productImages
        self.sortOrder = sortOrder
    }
    
}
