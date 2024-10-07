//
//  HomeTableViewCell.swift
//  SocialApp
//
//  Created by Andy on 23/09/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    lazy var contentVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
        
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var topHstack = UIStackView(frame: .zero)
    
    lazy var userImage = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.image, setTo: UIImage(named: "Avatar"))

    lazy var lblName = UILabel(frame: .zero)
        .with(\.textColor, setTo: UIColor(hexString: "242424"))
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.text, setTo: "Thanh Pham")
    
    lazy var lblTimeOnline = UILabel(frame: .zero)
        .with(\.textColor, setTo: UIColor(hexString: "BDBDBD"))
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
        .with(\.text, setTo: "1 hour ago")
    
    lazy var imageStatus = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.image, setTo: UIImage(named: "Photo"))
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bottomHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 6)
    
    lazy var btnPlus: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "plus-circle 1"), for: .normal)
        return btn
    }()
    
    lazy var lblCmtNumber = UILabel(frame: .zero)
        .with(\.textColor, setTo: UIColor(hexString: "212121"))
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
        .with(\.text, setTo: "20")
    
    lazy var btnCmt: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Chat"), for: .normal)
        return btn
    }()
    
    lazy var lblLoveNumber = UILabel(frame: .zero)
        .with(\.textColor, setTo: UIColor(hexString: "212121"))
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
        .with(\.text, setTo: "125")
    
    lazy var btnLove: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "heart 2"), for: .normal)
        return btn
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        self.backgroundColor = UIColor(hexString: "E0E0E0")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(contentVstack)
        contentVstack.addArrangedSubviews([topView, imageStatus, bottomView])
        topView.addSubview(topHstack)
        topHstack.addArrangedSubview(userImage)
        topHstack.addArrangedView(lblName, spacingAbove: 10)
        topHstack.addArrangedView(lblTimeOnline, spacingAbove: 16)
        
        bottomView.addSubview(bottomHstack)
        bottomHstack.addArrangedSubviews([btnPlus, lblCmtNumber, btnCmt, lblLoveNumber, btnLove])
        
        contentVstack.layer.cornerRadius = 10
        contentVstack.clipsToBounds = true
        
        
        contentVstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        topHstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
        }
        
        userImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        imageStatus.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        bottomHstack.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().offset(-12)
                make.leading.equalToSuperview().offset(14)
                make.trailing.equalToSuperview().offset(-14)
        }
        
        btnCmt.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        
        btnLove.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        
        btnPlus.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }

    }

}


