//
//  ProductsViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ProductsPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - ProductsPresenter Delegate

extension ProductsViewController: ProductsViewProtocol {}
