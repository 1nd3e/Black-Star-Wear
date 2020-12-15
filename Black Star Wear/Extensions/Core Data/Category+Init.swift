//
//  Category+Init.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 14.12.2020.
//

import CoreData

extension Category {
    
    convenience init(model: CategoriesItem, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = model.name
        self.sortOrder = model.sortOrder
    }
    
}
