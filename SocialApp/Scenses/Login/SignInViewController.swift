//
//  SignInViewController.swift
//  SocialApp
//
//  Created by Andy on 21/09/2024.
//

import UIKit
import Moya

class SignInViewController: UIViewController {

    let provider = MoyaProvider<APITarget>()
    
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
    
    lazy var tfEmail = UITextField(frame: .zero)
        .with(\.layer.cornerRadius, setTo: 25)
        .with(\.backgroundColor, setTo: UIColor(hexString: "F3F5F7"))
        .with(\.attributedPlaceholder, setTo: NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(hexString: "BDBDBD")]))
        .with(\.leftView, setTo: UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)))
        .with(\.leftViewMode, setTo: .always)
    
    lazy var tfEmail2 = UITextField(frame: .zero)
        .with(\.layer.cornerRadius, setTo: 26)
        .with(\.backgroundColor, setTo: UIColor(hexString: "F3F5F7"))
        .with(\.attributedPlaceholder, setTo: NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(hexString: "BDBDBD")]))
        .with(\.leftView, setTo: UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)))
        .with(\.leftViewMode, setTo: .always)
    
    lazy var tfPassword = UITextField(frame: .zero)
        .with(\.layer.cornerRadius, setTo: 25)
        .with(\.backgroundColor, setTo: UIColor(hexString: "F3F5F7"))
        .with(\.attributedPlaceholder, setTo: NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(hexString: "BDBDBD")]))
        .with(\.leftView, setTo: UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)))
        .with(\.leftViewMode, setTo: .always)
        .with(\.rightView, setTo: eyeView)
        .with(\.rightViewMode, setTo: .always)
    
    private lazy var eyeView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 44, height: 30))
        let btnEye = UIButton(type: .custom)
        view.addSubview(btnEye)
        btnEye.frame = .init(x: 0, y: 0, width: 24, height: 24)
        btnEye.setImage(UIImage(named: "Show"), for: .normal)
        btnEye.addTarget(nil, action: #selector(togglePassword), for: .touchUpInside)
        return view
    }()
    
    lazy var btnSignIn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("SIGN IN", for: .normal)
        btn.layer.cornerRadius = 26
        btn.clipsToBounds = true
        btn.backgroundColor = .clear
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(nil, action: #selector(clickToLogin), for: .touchUpInside)
        return btn
    }()
    
    lazy var gradientView = CustomViewForButton()
    
   
    lazy var signInHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 5)
    
    lazy var lblAlreadyAcc = UILabel(frame: .zero)
        .with(\.text, setTo: "Already have account?")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "606060"))
    
    lazy var btnSignInText: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("SIGN IN", for: .normal)
        btn.setTitleColor(UIColor(hexString: "5252C7"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        btn.addTarget(nil, action: #selector(clickToSignIn), for: .touchUpInside)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.addSubViews([topImg, bottomView])
        bottomView.addSubViews([bottomVstack, UIView()])
        bottomVstack.addArrangedSubview(tfEmail)
        bottomVstack.addArrangedView(tfEmail2, spacingAbove: 20)
        bottomVstack.addArrangedView(tfPassword, spacingAbove: 20)
        bottomVstack.addArrangedView(gradientView, spacingAbove: 40)
        bottomVstack.addArrangedView(signInHstack, spacingAbove: 40)
        signInHstack.addArrangedSubviews([lblAlreadyAcc, btnSignInText])
        gradientView.addSubview(btnSignIn)
 
        topImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(312)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(228)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        bottomVstack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        tfEmail.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview()
        }
        tfEmail2.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview()
        }
        tfPassword.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview()
        }
        gradientView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.horizontalEdges.equalToSuperview()
        }
        gradientView.layer.cornerRadius = 26
        gradientView.clipsToBounds = true
        
        btnSignIn.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.edges.equalToSuperview()
        }
    }
    
    @objc func togglePassword() {
        
    }
    @objc func clickToLogin() {
        let loginVC = VerifyViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    @objc func clickToSignIn() {
        
    }

}
