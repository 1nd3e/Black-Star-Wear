//
//  ProductsConfigurator.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class ProductsConfigurator {
    
    // MARK: - Types
    
    static let shared = ProductsConfigurator()
    
    // MARK: - Methods
    
    func configure(with model: Subcategory) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController else { return nil }
        let router = ProductsRouter(view: view)
        let presenter = ProductsPresenter(model: model, view: view, router: router)
        view.navigationItem.title = model.name
        view.presenter = presenter
        
        return view
    }
    
}
