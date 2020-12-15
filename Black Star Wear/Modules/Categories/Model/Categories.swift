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
    let sortOrder: String
    
    // MARK: - Initializers
    
    init?(data: Dictionary<String, Any>) {
        guard
            let name = data["name"] as? String,
            let imageURL = data["image"] as? String, imageURL.count > 0,
            let subcategories = data["subcategories"] as? Array<[String: Any]>, subcategories.count > 0,
            let sortOrder = data["sortOrder"] as? String
        else {
            return nil
        }
        
        self.name = name
        self.imageURL = imageURL
        self.subcategories = subcategories
        self.sortOrder = sortOrder
        
        print("\(name): \(sortOrder)")
    }
    
}

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
