//
//  SubcategoriesConfigurator.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class SubcategoriesConfigurator {
    
    // MARK: - Types
    
    static let shared = SubcategoriesConfigurator()
    
    // MARK: - Methods
    
    func configure(with category: Category) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Subcategories", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "SubcategoriesViewController") as? SubcategoriesViewController else { return nil }
        let router = SubcategoriesRouter(view: view)
        let presenter = SubcategoriesPresenter(view: view, router: router, category: category)
        view.presenter = presenter
        
        return view
    }
    
}
