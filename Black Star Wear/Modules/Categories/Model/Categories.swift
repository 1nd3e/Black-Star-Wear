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
    let subcategories: Array<[String: Any]>
    let sortOrder: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let name = data["name"] as? String,
            let subcategories = data["subcategories"] as? Array<[String: Any]>, subcategories.count > 0,
            let sortOrder = data["sortOrder"] as? String
        else {
            return nil
        }
        
        self.name = name
        self.subcategories = subcategories
        self.sortOrder = sortOrder
    }
    
}
