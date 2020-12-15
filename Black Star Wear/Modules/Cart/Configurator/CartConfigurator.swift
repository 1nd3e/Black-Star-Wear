//
//  CartConfigurator.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class CartConfigurator {
    
    // MARK: - Types
    
    static let shared = CartConfigurator()
    
    // MARK: - Methods
    
    func configure() -> UIViewController {
        let view = CartViewController()
        let router = CartRouter(view: view)
        let presenter = CartPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
