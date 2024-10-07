//
//  UIView+Extensions.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach(addSubview(_:))
    }
    
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = blur / 2.0
        if spread == 0 {
            self.layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = self.layer.bounds.insetBy(dx: dx, dy: dx)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIView {
    enum Point {
           case topLeft
           case centerLeft
           case bottomLeft
           case topCenter
           case center
           case bottomCenter
           case topRight
           case centerRight
           case bottomRight
           var point: CGPoint {
               switch self {
               case .topLeft:
                   return CGPoint(x: 0, y: 0)
               case .centerLeft:
                   return CGPoint(x: 0, y: 0.5)
               case .bottomLeft:
                   return CGPoint(x: 0, y: 1.0)
               case .topCenter:
                   return CGPoint(x: 0.5, y: 0)
               case .center:
                   return CGPoint(x: 0.5, y: 0.5)
               case .bottomCenter:
                   return CGPoint(x: 0.5, y: 1.0)
               case .topRight:
                   return CGPoint(x: 1.0, y: 0.0)
               case .centerRight:
                   return CGPoint(x: 1.0, y: 0.5)
               case .bottomRight:
                   return CGPoint(x: 1.0, y: 1.0)
               }
           }
       }
    
    func addGradientView(
        colors: [CGColor],
        startPoint: Point = .topCenter,
        endPoint: Point = .bottomCenter,
        locations: [NSNumber]
    ) {
        let gradientView = GradientView(
            colors: colors, startPoint: startPoint,
            endPoint: endPoint, locations: locations
        )
        
        self.addSubview(gradientView)
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.sendSubviewToBack(gradientView)
    }
}

final class GradientView: UIView {
    
    let colors: [CGColor]
    let startPoint: UIView.Point
    let endPoint: UIView.Point
    let locations: [NSNumber]
    
    private let gradientLayer = CAGradientLayer()

    init(
        colors: [CGColor],
        startPoint: UIView.Point,
        endPoint: UIView.Point,
        locations: [NSNumber]
    ) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.locations = locations

        super.init(frame: .zero)
        setupBGColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
       
    }
    
    private func setupBGColor() {
      
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
       
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
