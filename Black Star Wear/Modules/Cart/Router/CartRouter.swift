//
//  CartRouter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol CartRouterProtocol {
    init(view: UIViewController)
}

final class CartRouter: CartRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
