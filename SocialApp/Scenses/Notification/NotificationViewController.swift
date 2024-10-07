//
//  NotificationViewController.swift
//  SocialApp
//
//  Created by Andy on 02/10/2024.
//

import UIKit
import Moya
import Kingfisher

class NotificationViewController: UIViewController {
    
    let provider = MoyaProvider<APITarget>()
    
    lazy var topHstack = UIStackView(frame: .zero)
    
    lazy var lblActivity = UILabel(frame: .zero)
        .with(\.text, setTo: "Activities")
        .with(\.font, setTo: .systemFont(ofSize: 24, weight: .bold))
        .with(\.textColor, setTo: .black)
    
    lazy var lblNotiQty = UILabel(frame: .zero)
        .with(\.text, setTo: "(03)")
        .with(\.font, setTo: .systemFont(ofSize: 24, weight: .bold))
        .with(\.textColor, setTo: UIColor(hexString: "5151C6"))
    
    lazy var btnSetup: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "Setting"), for: .normal)
        return btn
    }()
    
    lazy var activityTableView = UITableView(frame: .zero)
        .with(\.separatorStyle, setTo: .none)
    
    var actResponse: [ActResponse.Activity] = [] {
        didSet {
            activityTableView.reloadData()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchingData()
    }
    
    private func fetchingData() {
        provider.request(.getActivity) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                do {
                    let activity = try decoder.decode(ActResponse.self, from: response.data)
                    self.actResponse = activity.activity ?? []
                    
                } catch {
                    print(error)
                }
                
            case .failure(_):
                break
                
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubViews([topHstack, activityTableView])
        topHstack.addArrangedSubviews([lblActivity, lblNotiQty, btnSetup])
        
        activityTableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: ActivityTableViewCell.identifier)
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.rowHeight = UITableView.automaticDimension
        activityTableView.estimatedRowHeight = 121
        activityTableView.showsVerticalScrollIndicator = false
        
        topHstack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        activityTableView.snp.makeConstraints { make in
            make.top.equalTo(topHstack.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview()
        }
        
        btnSetup.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        
        lblActivity.setContentHuggingPriority(.required, for: .horizontal)
        
    }
}

extension NotificationViewController: UITableViewDelegate {
    
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for: indexPath) as? ActivityTableViewCell else { return .init() }
        let activity = actResponse[indexPath.row]
        let userURLString = activity.userImg
        let notiImgUrlString = activity.image
        
        cell.userImgView.kf.setImage(with: URL(string: userURLString ?? ""))
        cell.lblUserName.text = activity.userName
        cell.lblAct.text = "\(activity.action ?? "") \(activity.status ?? "")"
        cell.lblOnlineTime.text = activity.onlineTime
        
        if activity.readStatus == "Unread" {
            cell.backView.backgroundColor = UIColor(hexString: "F1F1FE")
        } else {
            cell.backView.backgroundColor = UIColor(hexString: "F6F7F9")
        }
        
        if activity.follow == "Followed" {
            cell.btnFollow.isHidden = true
            cell.photoView.isHidden = false
            cell.notiImgView.kf.setImage(with: URL(string: notiImgUrlString ?? ""))
        } else {
            cell.btnFollow.isHidden = false
            cell.photoView.isHidden = true
        }
        return cell
    }
    
}


struct ActResponse: Codable {
    struct Activity: Codable {
        let id: Int?
        let userImg: String?
        let userName: String?
        let action: String?
        let status: String?
        let image: String?
        let onlineTime: String?
        let readStatus: String?
        let follow: String?
    }
    
    let id: Int?
    let activity: [Activity]?
}



@available(iOS 17.0, *)
#Preview {
    NotificationViewController()
}
