//
//  ProductsPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol ProductsViewProtocol: class {}

protocol ProductsPresenterProtocol {
    init(view: ProductsViewProtocol, router: ProductsRouterProtocol)
}

final class ProductsPresenter: ProductsPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: ProductsViewProtocol?
    private let router: ProductsRouterProtocol
    
    // MARK: - Initializers
    
    init(view: ProductsViewProtocol, router: ProductsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
