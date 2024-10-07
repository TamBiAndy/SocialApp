//
//  Withable.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit

protocol Withable {}

extension Withable where Self: UIView  {
    func with<S>(_ keypath: ReferenceWritableKeyPath<Self, S>, setTo value: S) -> Self {
        self[keyPath: keypath] = value
        
        return self
    }
}

extension UIStackView: Withable {}
extension UILabel: Withable {}
extension UIButton: Withable {}
extension UIImageView: Withable {}
extension UIScrollView: Withable {}
extension UITextField: Withable {}
