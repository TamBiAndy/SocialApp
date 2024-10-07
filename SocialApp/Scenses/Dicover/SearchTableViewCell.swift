//
//  SearchTableViewCell.swift
//  SocialApp
//
//  Created by Andy on 05/10/2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    lazy var collectImg = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.image, setTo: UIImage(named: "Cards"))
    
    lazy var lblCollectTitle = UILabel(frame: .zero)
        .with(\.font, setTo: .systemFont(ofSize: 20, weight: .bold))
        .with(\.textColor, setTo: .white)
        .with(\.text, setTo: "Photography")
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubViews([collectImg, lblCollectTitle])
        
        collectImg.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(140)
        }
        
        lblCollectTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    SearchTableViewCell()
}
