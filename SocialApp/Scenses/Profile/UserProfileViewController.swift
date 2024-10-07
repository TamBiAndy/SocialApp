//
//  UserProfileViewController.swift
//  SocialApp
//
//  Created by Andy on 03/10/2024.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    lazy var headBackground = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "Header background"))
        .with(\.contentMode, setTo: .scaleToFill)
    
    lazy var contentVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
        .with(\.alignment, setTo: .center)
    
    lazy var userImgView = UIImageView(frame: .zero)
        .with(\.image, setTo: UIImage(named: "Avatar"))
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.clipsToBounds, setTo: true)
        .with(\.layer.cornerRadius, setTo: 40)
        .with(\.layer.borderWidth, setTo: 4)
        .with(\.layer.borderColor, setTo: UIColor(named: "FFFFFF")?.cgColor)
    
    lazy var lblUserName = UILabel(frame: .zero)
        .with(\.text, setTo: "Bruno Pham")
        .with(\.font, setTo: .systemFont(ofSize: 20, weight: .bold))
        .with(\.textColor, setTo: UIColor(hexString: "333333"))
        .with(\.textAlignment, setTo: .center )
            
    lazy var lblLocation = UILabel(frame: .zero)
        .with(\.text, setTo: "Da Nang, Vietnam")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "8F90A7"))
        .with(\.textAlignment, setTo: .center )
                                          
    lazy var followView = UIView(frame: .zero)
    
    lazy var lblFollower = UILabel(frame: .zero)
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "212121"))
        .with(\.textAlignment, setTo: .center )
    
    lazy var lblFollowing = UILabel(frame: .zero)
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "212121"))
        .with(\.textAlignment, setTo: .center )
    
    lazy var socialHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 24)
        .with(\.alignment, setTo: .center)
    
    lazy var btnWeb: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "globe 1"), for: .normal)
        return btn
    }()
    
    lazy var btnInsta: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "u_instagram"), for: .normal)
        return btn
    }()
    
    lazy var btnFB: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "facebook 1"), for: .normal)
        return btn
    }()
    
    lazy var dotView = UIView(frame: .zero)
    
    lazy var dotView1 = UIView(frame: .zero)
    
    var segmentView = SegmentView()
    
                                   
                                          

    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "@brunoPham"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let settingButtonItem = UIBarButtonItem(
            image: UIImage(named: "Setting1"),
            style: .done,
            target: self, action: #selector(settingButtonTapped)
        )
        
        let backButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_back"),
            style: .plain,
            target: self, action: #selector(settingButtonTapped)
        )
        
        backButtonItem.tintColor = .white
        settingButtonItem.tintColor = .white
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.rightBarButtonItems = [settingButtonItem]
    }
    
    @objc func settingButtonTapped() {
        print("Setting Tapped")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupview() {
        view.backgroundColor = .white
        view.addSubViews([headBackground, contentVstack])
        contentVstack.addArrangedView(userImgView, spacingAbove: 27)
        contentVstack.addArrangedView(lblUserName, spacingAbove: 16)
        contentVstack.addArrangedView(lblLocation, spacingAbove: 6)
        contentVstack.addArrangedView(followView, spacingAbove: 20)
        contentVstack.addArrangedView(socialHstack, spacingAbove: 20)
        contentVstack.addArrangedView(segmentView, spacingAbove: 29)
        
        followView.addSubViews([lblFollower, lblFollowing])
        socialHstack.addArrangedSubviews([btnWeb, dotView, btnInsta, dotView1, btnFB])
        
        
        headBackground.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(190)
        }
        
        contentVstack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        userImgView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        
        followView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview()
        }
        
        followView.backgroundColor = UIColor(hexString: "F6F7F9")
        
        lblFollower.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
                .offset(46)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        lblFollowing.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(lblFollower.snp.trailing)
                .offset(48)
            make.trailing.equalToSuperview().offset(-46)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        btnWeb.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        btnInsta.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        btnFB.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        dotView.snp.makeConstraints { make in
            make.height.width.equalTo(6)
        }
        dotView.backgroundColor = UIColor(hexString: "5151C6")
        dotView.layer.cornerRadius = 3
        
        dotView1.snp.makeConstraints { make in
            make.height.width.equalTo(6)
        }
        dotView1.backgroundColor = UIColor(hexString: "5151C6")
        dotView1.layer.cornerRadius = 3
        
        segmentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        // setup attributes string
        lblFollower.attributedText = createAttributeString(for: "100 follower")
        lblFollowing.attributedText = createAttributeString(for: "150 following")
    }
    
    func createAttributeString(for string: String) -> NSAttributedString {
        var characters = string.components(separatedBy: " ")
        let firstString = characters.removeFirst()
        let lastString = characters.joined(separator: " ")
        let attribute = NSMutableAttributedString(string: firstString, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "5151C6"),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ])
        
        attribute.append(NSAttributedString(string: " " + lastString, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "BDBDBD"),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        ]))
        
        return attribute
    }
}
