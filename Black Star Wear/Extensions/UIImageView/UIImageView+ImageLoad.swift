//
//  UIImageView+ImageLoad.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

extension UIImageView {
    
    // Загружает изображение по ссылке из сети.
    func loadImage(from url: String) {
        self.image = nil
        
        DataProvider.shared.loadImage(from: url) { [weak self] data in
            self?.image = UIImage(data: data)
        }
    }
    
}
