//
//  SubcategoriesRouter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol SubcategoriesRouterProtocol {
    init(view: UIViewController)
    func moveToProducts(subcategory: Subcategory)
}

final class SubcategoriesRouter: SubcategoriesRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    
    func moveToProducts(subcategory: Subcategory) {
        guard
            let view = view, let navigationController = view.navigationController,
            let viewController = ProductsConfigurator.shared.configure(with: subcategory)
        else {
            return
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
