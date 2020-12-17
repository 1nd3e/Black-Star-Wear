//
//  Product+Init.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 16.12.2020.
//

import CoreData

extension Product {
    
    convenience init(model: ProductsItem, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = model.name
        self.overview = model.description
        self.price = model.price
        self.thumbImageUrl = model.thumbImageUrl
        self.productImages = model.productImages
        self.sortOrder = model.sortOrder
    }
    
}
