//
//  CircleView.swift
//  Black Star Wear
//
//  Created by Vladislav Len on 14.12.2020.
//

import UIKit

final class CircleView: UIView {
    
    // MARK: - UIView Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCornerRadius()
    }
    
    // MARK: - Methods
    
    // Округляет углы вьюшки.
    private func setCornerRadius() {
        let viewHeight = self.frame.height
        let cornerRadius = viewHeight / 2
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
}
