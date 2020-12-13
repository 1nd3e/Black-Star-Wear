//
//  CategoriesRouter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

protocol CategoriesRouterProtocol {
    init(view: UIViewController)
}

final class CategoriesRouter: CategoriesRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
