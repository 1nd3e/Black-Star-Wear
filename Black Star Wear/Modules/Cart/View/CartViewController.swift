//
//  CartViewController.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: CartPresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeAppearance()
    }
    
}

// MARK: - Appearance Customization

extension CartViewController {
    
    // Группирует методы кастомизации представления.
    private func customizeAppearance() {
        setNavigationLogo()
    }
    
    // Устанавливает логотип в панели навигации.
    private func setNavigationLogo() {
        guard let logoImage = UIImage(named: "logo") else { return }
        
        let logoView = UIImageView()
        logoView.image = logoImage
        
        self.navigationItem.titleView = logoView
    }
    
}

// MARK: - CartPresenter Delegate

extension CartViewController: CartViewProtocol {}
