//
//  Categories.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import Foundation

struct CategoriesItem {
    
    // MARK: - Properties
    
    let name: String
    var imageURL: String
    let subcategories: Array<[String: Any]>
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let name = data["name"] as? String,
            let imageURL = data["image"] as? String, imageURL.count > 0,
            let subcategories = data["subcategories"] as? Array<[String: Any]>, subcategories.count > 0
        else {
            return nil
        }
        
        self.name = name
        self.imageURL = imageURL
        self.subcategories = subcategories
    }
    
}
