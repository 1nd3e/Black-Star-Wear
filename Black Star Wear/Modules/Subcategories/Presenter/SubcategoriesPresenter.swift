//
//  SubcategoriesPresenter.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

protocol SubcategoriesViewProtocol: class {}

protocol SubcategoriesPresenterProtocol {
    init(view: SubcategoriesViewProtocol, router: SubcategoriesRouterProtocol)
}

final class SubcategoriesPresenter: SubcategoriesPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SubcategoriesViewProtocol?
    private let router: SubcategoriesRouterProtocol
    
    // MARK: - Initializers
    
    init(view: SubcategoriesViewProtocol, router: SubcategoriesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
