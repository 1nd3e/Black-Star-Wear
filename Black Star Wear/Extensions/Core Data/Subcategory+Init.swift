//
//  Subcategory+Init.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 14.12.2020.
//

import CoreData

extension Subcategory {
    
    convenience init(model: SubcategoriesItem, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = model.id
        self.name = model.name
        self.sortOrder = model.sortOrder
    }
    
}
