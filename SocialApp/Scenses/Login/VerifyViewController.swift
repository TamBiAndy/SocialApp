//
//  VerifyViewController.swift
//  SocialApp
//
//  Created by Andy on 21/09/2024.
//

import UIKit

class VerifyViewController: UIViewController {

    lazy var topImg = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "topImgLogin"))
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 28
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bottomVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
        .with(\.alignment, setTo: .center)
    
    lazy var lblTop = UILabel(frame: .zero)
        .with(\.text, setTo: "VERIFICATION")
        .with(\.font, setTo: .boldSystemFont(ofSize: 16))
        .with(\.textColor, setTo: UIColor(hexString: "5151C6"))
    
    lazy var messageView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hexString: "F1F1FE")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var lblMessage = UILabel(frame: .zero)
        .with(\.text, setTo: "A message with verification code was sent to your mobile phone.")
        .with(\.font, setTo: .systemFont(ofSize: 18, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "242424"))
        .with(\.numberOfLines, setTo: 0)
    
    lazy var tfVerifyNumber = UITextField(frame: .zero)
        .with(\.layer.cornerRadius, setTo: 26)
        .with(\.backgroundColor, setTo: UIColor(hexString: "F3F5F7"))
        .with(\.attributedPlaceholder, setTo: NSAttributedString(string: "Type verification code", attributes: [.foregroundColor: UIColor(hexString: "BDBDBD")]))
        .with(\.leftView, setTo: UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)))
        .with(\.leftViewMode, setTo: .always)
    
    lazy var btnDontReceive: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Don't receive the code", for: .normal)
        btn.setTitleColor(UIColor(hexString: "242424"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        btn.addTarget(nil, action: #selector(clickToResendCode), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnVerify: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("VERIFY", for: .normal)
        btn.layer.cornerRadius = 26
        btn.clipsToBounds = true
        btn.backgroundColor = .clear
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(nil, action: #selector(clickToVerify), for: .touchUpInside)
        return btn
    }()
    
    lazy var gradientView = CustomViewForButton()
    
    lazy var bottomImg = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "Group 7030"))
        .with(\.contentMode, setTo: .scaleAspectFit)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }
    
    private func setupView() {
        view.addSubViews([topImg, bottomView])
        bottomView.addSubview(bottomVstack)
        bottomVstack.addArrangedSubview(lblTop)
        bottomVstack.addArrangedView(messageView, spacingAbove: 14)
        bottomVstack.addArrangedView(tfVerifyNumber, spacingAbove: 40)
        bottomVstack.addArrangedView(btnDontReceive, spacingAbove: 40)
        bottomVstack.addArrangedView(gradientView, spacingAbove: 40)
        bottomVstack.addArrangedView(bottomImg, spacingAbove: 66)
        
        messageView.addSubview(lblMessage)
        gradientView.addSubview(btnVerify)
        
        topImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(312)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(178)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bottomVstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.horizontalEdges.equalToSuperview()
        }
        messageView.snp.makeConstraints { make in
            make.height.equalTo(86)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        lblMessage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        tfVerifyNumber.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(52)
        }
        gradientView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        gradientView.layer.cornerRadius = 26
        gradientView.clipsToBounds = true
        btnVerify.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.edges.equalToSuperview()
        }
        bottomImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-75)
            make.height.equalTo(91)
        }
   
    }
    

    @objc func clickToResendCode() {
        
    }
    @objc func clickToVerify() {
        
    }

}
