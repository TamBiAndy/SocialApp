//
//  UIStackView+Extension.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit

extension UIStackView {
    func addArrangedView(_ view: UIView, spacingAbove: CGFloat) {
        self.addArrangedSubview(view)
        
        guard let index = self.arrangedSubviews.firstIndex(of: view), index > 0 else { return }
        let aboveView = self.arrangedSubviews[index - 1]
        setCustomSpacing(spacingAbove, after: aboveView)
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }
}
