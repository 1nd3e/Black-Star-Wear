//
//  CategoriesViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 13.12.2020.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CategoriesPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - CategoriesPresenter Delegate

extension CategoriesViewController: CategoriesViewProtocol {}
