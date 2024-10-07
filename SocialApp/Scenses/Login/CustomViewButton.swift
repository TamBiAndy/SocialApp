//
//  CustomViewButton.swift
//  SocialApp
//
//  Created by Andy on 21/09/2024.
//

import UIKit

class CustomViewForButton: UIView {
    lazy var gradientView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundColor() {
        self.addSubview(gradientView)
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let colors = [
            UIColor(hexString: "5151C6").cgColor,
            UIColor(hexString: "888BF4").cgColor
        ].compactMap { $0 }
        

        let locations: [NSNumber] = [0.0, 1]
        
        gradientView.addGradientView(
            colors: colors, startPoint: .centerLeft,
            endPoint: .centerRight, locations: locations
        )
    }
}
