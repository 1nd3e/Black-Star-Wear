//
//  ProductsCollectionViewCell.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 15.12.2020.
//

import UIKit
import Kingfisher

final class ProductsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
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
        priceLabel.text = price
        
        self.setThumbImage(from: thumbImageUrl)
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
    
    // Устанавливает изображение превью товара.
    func setThumbImage(from path: String) {
        guard let url = URL(string: "https://blackstarshop.ru/\(path)") else { return }
        
        let fadeImageTransition: ImageTransition  = .fade(0.2)
        let transition: KingfisherOptionsInfoItem = .transition(fadeImageTransition)
        
        thumbImageView.kf.indicatorType = .activity
        thumbImageView.kf.setImage(with: url, options: [transition])
    }
    
}
