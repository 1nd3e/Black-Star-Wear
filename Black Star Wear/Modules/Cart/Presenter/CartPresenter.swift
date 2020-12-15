//
//  CartPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol CartViewProtocol: class {}

protocol CartPresenterProtocol {
    init(view: CartViewProtocol, router: CartRouterProtocol)
}

final class CartPresenter: CartPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: CartViewProtocol?
    private let router: CartRouterProtocol
    
    // MARK: - Initializers
    
    init(view: CartViewProtocol, router: CartRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
