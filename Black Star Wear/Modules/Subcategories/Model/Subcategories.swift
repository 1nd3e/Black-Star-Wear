//
//  Subcategories.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import Foundation

struct SubcategoriesItem {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    let sortOrder: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let id = data["id"] as? String,
            let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.sortOrder = sortOrder
    }
    
}
