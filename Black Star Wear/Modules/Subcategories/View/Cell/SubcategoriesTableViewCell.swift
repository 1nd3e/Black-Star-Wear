//
//  SubcategoriesTableViewCell.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class SubcategoriesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Methods
    
    // Конфигурирует ячейку с данными из модели.
    func configure(with model: Subcategory) {
        guard let name = model.name else { return }
        titleLabel.text = name
    }
}
