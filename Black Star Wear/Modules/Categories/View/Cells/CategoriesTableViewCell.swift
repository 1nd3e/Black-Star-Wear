//
//  CategoriesTableViewCell.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 14.12.2020.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbImageView: UIImageView!
    
    // MARK: - Methods
    
    // Конфигурирует ячейку с данными из модели.
    func configure(with model: Category) {
        guard
            let name = model.name,
            let imageURL = model.imageURL
        else {
            return
        }
        
        titleLabel.text = name
        thumbImageView.loadImage(from: imageURL)
    }
    
}
