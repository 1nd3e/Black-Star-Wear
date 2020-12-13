//
//  CategoriesPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

protocol CategoriesViewProtocol: class {}

protocol CategoriesPresenterProtocol {
    init(view: CategoriesViewProtocol, router: CategoriesRouterProtocol)
}

final class CategoriesPresenter: CategoriesPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: CategoriesViewProtocol?
    private let router: CategoriesRouterProtocol
    
    // MARK: - Initializers
    
    init(view: CategoriesViewProtocol, router: CategoriesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
