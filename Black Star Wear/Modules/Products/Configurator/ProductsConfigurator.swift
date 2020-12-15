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
    
    func configure() -> UIViewController {
        let view = ProductsViewController()
        let router = ProductsRouter(view: view)
        let presenter = ProductsPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
