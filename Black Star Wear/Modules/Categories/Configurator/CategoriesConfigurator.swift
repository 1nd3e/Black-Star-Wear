//
//  CategoriesConfigurator.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

final class CategoriesConfigurator {
    
    // MARK: - Types
    
    static let shared = CategoriesConfigurator()
    
    // MARK: - Methods
    
    func configure() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Categories", bundle: nil)
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "CategoriesNavigationController") as? UINavigationController,
            let view = navigationController.viewControllers.first as? CategoriesViewController else {
                return nil
        }
        
        let router = CategoriesRouter(view: view)
        let presenter = CategoriesPresenter(view: view, router: router)
        view.presenter = presenter
        
        return navigationController
    }
    
}
