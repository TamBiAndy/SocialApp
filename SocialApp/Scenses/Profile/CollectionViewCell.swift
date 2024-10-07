//
//  CollectionView.swift
//  SocialApp
//
//  Created by Andy on 04/10/2024.
//

import UIKit

class ShotCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShotCollectionViewCell"
    
    lazy var shotImgView = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.clipsToBounds, setTo: true)
        .with(\.layer.cornerRadius, setTo: 10)
        .with(\.image, setTo: UIImage(named: "topImgLogin"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(shotImgView)
        shotImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            let screenWidth = (UIScreen.main.bounds.width - 54)
            let cellWidth = screenWidth/2
            make.width.equalTo(cellWidth)
            make.height.equalTo(cellWidth * 190/155)
        }
    }
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    
    lazy var collectImgView = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.clipsToBounds, setTo: true)
        .with(\.layer.cornerRadius, setTo: 10)
        .with(\.image, setTo: UIImage(named: "topImgLogin"))
    
    lazy var lbllTitle = UILabel(frame: .zero)
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .bold))
        .with(\.textAlignment, setTo: .center)
        .with(\.textColor, setTo: .white)
        .with(\.text, setTo: "Download")
    
    lazy var lblshotQty = UILabel(frame: .zero)
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
        .with(\.textAlignment, setTo: .center)
        .with(\.textColor, setTo: UIColor(hexString: "828282"))
        .with(\.text, setTo: "25 shots")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubViews([collectImgView, lbllTitle, lblshotQty])
        
        collectImgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(collectImgView.snp.width)
        }
        
        lbllTitle.snp.makeConstraints { make in
            make.center.equalTo(collectImgView.snp.center)
        }
        
        lblshotQty.snp.makeConstraints { make in
            make.top.equalTo(collectImgView.snp.bottom).offset(6)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

