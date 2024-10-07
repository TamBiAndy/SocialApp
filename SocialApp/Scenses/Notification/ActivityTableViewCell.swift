//
//  ActivityTableViewCell.swift
//  SocialApp
//
//  Created by Andy on 02/10/2024.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    static let identifier = "ActivityTableViewCell"
    
    lazy var backView = UIView(frame: .zero)
    
    lazy var contentHstack = UIStackView(frame: .zero)
        .with(\.alignment, setTo: .top)
        .with(\.spacing, setTo: 14)
    
    lazy var userImgView = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.layer.cornerRadius, setTo: 15)
    
    lazy var actVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
    
    lazy var lblUserName = UILabel(frame: .zero)
        .with(\.text, setTo: "Bruno Pham")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .bold))
        .with(\.textColor, setTo: .black)
    
    lazy var lblAct = UILabel(frame: .zero)
        .with(\.text, setTo: "liked “Autumn in my heart”")
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
    
    lazy var lblOnlineTime = UILabel(frame: .zero)
        .with(\.text, setTo: "2 minutes ago")
        .with(\.font, setTo: .systemFont(ofSize: 12, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "BDBDBD"))
    
    lazy var rightStack = UIStackView(frame: .zero)
        .with(\.alignment, setTo: .top)
    
    lazy var photoView = UIView(frame: .zero)
    
    lazy var notiImgView = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
    
    lazy var heartImgView = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.image, setTo: UIImage(named: "Component 7037"))
    
    lazy var btnFollow: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Follow", for: .normal)
        btn.layer.cornerRadius = 16
        btn.layer.borderColor = UIColor(hexString: "5151C6").cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(UIColor(hexString: "5151C6"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .ultraLight)
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.selectionStyle = .none
        contentView.addSubview(backView)
        backView.layer.cornerRadius = 10
        backView.addSubview(contentHstack)
        contentHstack.addArrangedSubviews([userImgView, actVstack, rightStack])
        
        actVstack.addArrangedSubview(lblUserName)
        actVstack.addArrangedView(lblAct, spacingAbove: 4)
        actVstack.addArrangedView(lblOnlineTime, spacingAbove: 10)
        
        rightStack.addArrangedSubviews([photoView, btnFollow])
        
        photoView.addSubViews([notiImgView, heartImgView])
        
        backView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentHstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-14)
        }
        
        userImgView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        userImgView.layer.cornerRadius = 15
        userImgView.clipsToBounds = true
        
        photoView.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.width.equalTo(89)
        }
        
        notiImgView.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(81)
//            make.top.equalToSuperview().offset(9)
//            make.trailing.equalToSuperview().offset(-8)
            make.leading.bottom.equalToSuperview()
        }
        
        heartImgView.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.top.trailing.equalToSuperview()
        }
        heartImgView.layer.cornerRadius = 9
        
        btnFollow.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(62)
        }
        
        
        
        
        
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
    ActivityTableViewCell()
}
