//
//  ProductsCollectionViewCell.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit

final class ProductsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setContentConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setContentConstraint()
    }
    
    // MARK: - Public Methods
    
    // Конфигурирует ячейку с данными из модели.
    func configure(with model: Product) {
        guard
            let name = model.name,
            let description = model.overview,
            let thumbImageUrl = model.thumbImageUrl,
            let price = model.price
        else {
            return
        }
        
        titleLabel.text = name
        descriptionLabel.text = description
        thumbImageView.loadImage(from: thumbImageUrl)
        priceLabel.text = price
    }
    
    // MARK: - Private Methods
    
    // Устанавливает ограничение ширины контента ячейки.
    private func setContentConstraint() {
        let rootSize = UIScreen.main.bounds.size
        let layoutInsets = CGFloat(48)
        let relativeCellWidth = (rootSize.width - layoutInsets) / 2
        
        self.contentView.widthAnchor.constraint(equalToConstant: relativeCellWidth)
            .isActive = true
    }
    
}
