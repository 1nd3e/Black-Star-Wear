//
//  SubcategoriesViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class SubcategoriesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: SubcategoriesPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - SubcategoriesPresenter Delegate

extension SubcategoriesViewController: SubcategoriesViewProtocol {}
