//
//  SubcategoriesRouter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol SubcategoriesRouterProtocol {
    init(view: UIViewController)
}

final class SubcategoriesRouter: SubcategoriesRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
