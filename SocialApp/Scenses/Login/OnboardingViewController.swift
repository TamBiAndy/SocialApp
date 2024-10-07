//
//  OnboardingViewController.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    lazy var contentVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
        .with(\.alignment, setTo: .center)

    lazy var backgroundImg = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "Dark Background"))
    
    lazy var titleImg = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "ic_title"))
    
    lazy var centerImg = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "BoardingImg"))
    
    lazy var lblTitle = UILabel(frame: .zero)
        .with(\.text, setTo: "SHARE - INSPIRE - CONNECT")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: .white)
    
    lazy var btnGetStarted: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("GET STARTED", for: .normal)
        btn.layer.cornerRadius = 26
        btn.backgroundColor = UIColor(hexString: "D0D0D0").withAlphaComponent(0.3)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(nil, action: #selector(clickToLogin), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        view.addSubview(backgroundImg)
        view.addSubview(contentVstack)
        contentVstack.addArrangedSubview(titleImg)
        contentVstack.addArrangedView(centerImg, spacingAbove: 33)
        contentVstack.addArrangedView(lblTitle, spacingAbove: 33)
        contentVstack.addArrangedView(btnGetStarted, spacingAbove: 43)
        
        backgroundImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentVstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.bottom.equalToSuperview().offset(-109)
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
        }
        
        titleImg.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(100)
        }
        
        centerImg.snp.makeConstraints { make in
            make.height.equalTo(422)
            make.width.equalTo(333)
        }
        
        btnGetStarted.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.width.equalTo(158)
        }
    
    }
    
    @objc func clickToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
}

