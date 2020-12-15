//
//  CategoriesRouter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

protocol CategoriesRouterProtocol {
    init(view: UIViewController)
    
    func moveToSubcategories(category: Category)
}

final class CategoriesRouter: CategoriesRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    
    func moveToSubcategories(category: Category) {
        guard
            let view = view, let navigationController = view.navigationController,
            let viewController = SubcategoriesConfigurator.shared.configure(with: category)
        else {
            return
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
