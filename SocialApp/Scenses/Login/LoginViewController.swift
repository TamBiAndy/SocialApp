//
//  LoginViewController.swift
//  SocialApp
//
//  Created by Andy on 20/09/2024.
//

import UIKit
import Moya

class SessionManager {
    static let shared = SessionManager()
    
    var token = ""
}

class LoginViewController: UIViewController {
    
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
    
    lazy var btnForgot: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("FORGOT PASSWORD", for: .normal)
        btn.layer.cornerRadius = 26
        btn.setTitleColor(UIColor(hexString: "5252C7"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        btn.addTarget(nil, action: #selector(findPassWord), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnLogin: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("LOG IN", for: .normal)
        btn.layer.cornerRadius = 26
        btn.clipsToBounds = true
        btn.backgroundColor = .clear
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(nil, action: #selector(clickToLogin), for: .touchUpInside)
        return btn
    }()
    
    lazy var gradientView = CustomViewForButton()
    
    lazy var lblTitle = UILabel(frame: .zero)
        .with(\.text, setTo: "OR LOG IN BY")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "606060"))
    
    lazy var loginHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 20)
    
    lazy var btnGoogle: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_google"), for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(hexString: "E3E4FC")
        btn.addTarget(nil, action: #selector(loginByGoogle), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnFacebook: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_FB"), for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(hexString: "E3E4FC")
        btn.addTarget(nil, action: #selector(loginByFB), for: .touchUpInside)
        return btn
    }()
    
    lazy var signUpHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 5)
    
    lazy var lblNoAcc = UILabel(frame: .zero)
        .with(\.text, setTo: "Don't have account?")
        .with(\.font, setTo: .systemFont(ofSize: 16, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "606060"))
    
    lazy var btnSignUp: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("SIGN UP", for: .normal)
        btn.setTitleColor(UIColor(hexString: "5252C7"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .light)
        btn.addTarget(nil, action: #selector(clickToSignUp), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func signIn(_ completion: @escaping (Bool) -> Void) {
        provider.request(.logIn(email: tfEmail.text ?? "", password: tfPassword.text ?? "")) { result in
            switch result {
            case .success(let response):
                do {
                    if (200...299).contains(response.statusCode) {
                        completion(true)
                        let decoder = JSONDecoder()
                        let logInResponse = try decoder.decode(LoginResponse.self, from: response.data)
                        SessionManager.shared.token = logInResponse.data?.token ?? ""
                        print(logInResponse.data?.token)
//                        let jsonResponse = try response.mapJSON() as? [String: Any]
//                        let token = jsonResponse?["access_toke"] as? String
                    } else {
                        completion(false)
                        print("Invalid status code: \(response.statusCode)")
                    }
                } catch {
                    print(error)
                }
            case .failure(_):
                break
            }
        }
    }
    
    
    private func setupView() {
        view.addSubViews([topImg, bottomView])
        bottomView.addSubViews([bottomVstack, UIView()])
        bottomVstack.addArrangedSubview(tfEmail)
        bottomVstack.addArrangedView(tfPassword, spacingAbove: 20)
        bottomVstack.addArrangedView(btnForgot, spacingAbove: 20)
        bottomVstack.addArrangedView(gradientView, spacingAbove: 40)
        bottomVstack.addArrangedView(lblTitle, spacingAbove: 40)
        bottomVstack.addArrangedView(loginHstack, spacingAbove: 14)
        bottomVstack.addArrangedView(signUpHstack, spacingAbove: 40)
        
        gradientView.addSubview(btnLogin)
        loginHstack.addArrangedSubviews([UIView(),btnGoogle, btnFacebook, UIView()])
        signUpHstack.addArrangedSubviews([lblNoAcc, btnSignUp])
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
        
        btnLogin.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.edges.equalToSuperview()
        }
        btnGoogle.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        btnFacebook.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
    }
    
    @objc func togglePassword() {
        
        
    }
    @objc func findPassWord() {
        
    }
    
    @objc func clickToLogin() {
        signIn { isSuccess in
            if isSuccess {
                let loginVC = HomeViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            } else {
                
            }
        }
    }
    @objc func loginByGoogle() {
        
    }
    @objc func loginByFB() {
        
    }
    @objc func clickToSignUp() {
        let loginVC = SignInViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
}

struct LoginResponse: Codable {
  struct Data: Codable {
    let userID: Int?
    let email: String?
    let password: String?
    let token: String?

    private enum CodingKeys: String, CodingKey {
      case userID = "userId"
      case email
      case password
      case token
    }
  }

  let status: String?
  let message: String?
  let data: Data?
}
