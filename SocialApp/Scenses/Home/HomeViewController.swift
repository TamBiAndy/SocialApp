//
//  HomeViewController.swift
//  SocialApp
//
//  Created by Andy on 22/09/2024.
//

import UIKit
import Moya
import Kingfisher

class HomeViewController: UIViewController {
    let provider = MoyaProvider<APITarget>()

    lazy var contentVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
    
    lazy var topHstack = UIStackView(frame: .zero)
        .with(\.spacing, setTo: 16)
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        return searchBar
    }()
    
    lazy var btnSendCopy: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hexString: "F6F7F9")
        btn.setImage(UIImage(named: "Send copy"), for: .normal)
        btn.layer.cornerRadius = 18
        return btn
    }()
    
    lazy var segmentedView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Popular", "Trending", "Following"])
        segment.selectedSegmentIndex = 0
        segment.subviews.forEach { $0.backgroundColor = .white }
        segment.selectedSegmentTintColor = .init(hexString: "F1F1FE")
        segment.layer.borderWidth = 0
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segment.setTitleTextAttributes([.foregroundColor: UIColor(hexString: "5151C6"), .font: UIFont.boldSystemFont(ofSize: 16)], for: .selected)
        segment.setTitleTextAttributes([.foregroundColor: UIColor(hexString: "BDBDBD"), .font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return segment
    }()
    
    // Ba UIView cho từng trường hợp
    lazy var popularView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var trendingView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var followingView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var tableView = UITableView(frame: .zero)
        
    
    var popularResponse: [HomeResponse.Data.Popular] = []
    var trendingResponse: [HomeResponse.Data.Trending] = []
    var followingResponse: [HomeResponse.Data.Following] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setSearchBarBorder(color: .clear)
        setupTableView()
        fetchingData()
      
    }
    
    private func setupView() {
        view.addSubViews([topHstack, segmentedView, tableView])
        topHstack.addArrangedSubviews([searchBar, btnSendCopy])
        segmentedView.addSubViews([segmentedControl, popularView, trendingView, followingView])
       

        
        topHstack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        btnSendCopy.snp.makeConstraints { make in
            make.height.width.equalTo(36)
        }
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(topHstack.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(39)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popularView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        trendingView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        followingView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        
        searchBar.delegate = self
        
    }
    
    private func fetchingData() {
        provider.request(.getInforbySegment) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                
                do {
                    let homeResponse = try decoder.decode(HomeResponse.self, from: response.data)
                    self.popularResponse = homeResponse.data?.popular ?? []
                    self.trendingResponse = homeResponse.data?.trending ?? []
                    self.followingResponse = homeResponse.data?.following ?? []
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
                
                
            case .failure(_):
                break
            }
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 319
        
    }
    
    @objc func segmentChanged(sender: UISegmentedControl) {
        showView(for: sender.selectedSegmentIndex)
        self.tableView.reloadData()
    }
    
    // Hiển thị view tương ứng với segment được chọn
    func showView(for index: Int) {
        popularView.isHidden = index != 0
        trendingView.isHidden = index != 1
        followingView.isHidden = index != 2
    }
    
    private func createImageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return popularResponse.count
        case 1:
            return trendingResponse.count
        case 2:
            return followingResponse.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
         guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return .init() }
            let popular = popularResponse[indexPath.row]
            let urlUserImg = URL(string: popular.userImage ?? "")
            let urlImgStatus = URL(string: popular.statusImage ?? "")
            cell.userImage.kf.setImage(with: urlUserImg)
            cell.lblName.text = popular.userName
            cell.lblTimeOnline.text = popular.onlineStatus
            cell.imageStatus.kf.setImage(with: urlImgStatus)
            cell.lblCmtNumber.text = "\(popular.commentCount ?? 0)"
            cell.lblLoveNumber.text = "\(popular.likeCount ?? 0)"
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return .init() }
               let trending = trendingResponse[indexPath.row]
               let urlUserImg = URL(string: trending.userImage ?? "")
               let urlImgStatus = URL(string: trending.statusImage ?? "")
               cell.userImage.kf.setImage(with: urlUserImg)
               cell.lblName.text = trending.userName
            cell.lblTimeOnline.text = trending.onlineStatus
               cell.imageStatus.kf.setImage(with: urlImgStatus)
               cell.lblCmtNumber.text = "\(trending.commentCount ?? 0)"
               cell.lblLoveNumber.text = "\(trending.likeCount ?? 0)"
               return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return .init() }
               let following = followingResponse[indexPath.row]
               let urlUserImg = URL(string: following.userImage ?? "")
               let urlImgStatus = URL(string: following.statusImage ?? "")
               cell.userImage.kf.setImage(with: urlUserImg)
               cell.lblName.text = following.userName
            cell.lblTimeOnline.text = following.onlineStatus
               cell.imageStatus.kf.setImage(with: urlImgStatus)
               cell.lblCmtNumber.text = "\(following.commentCount ?? 0)"
               cell.lblLoveNumber.text = "\(following.likeCount ?? 0)"
               return cell
        default:
            break
        }
        return .init()
    }
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = "Type something"
        setSearchBarBorder(color: UIColor(hexString: "5151C6"))
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    // Khi kết thúc chỉnh sửa (thoát khỏi searchBar)
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = "Search"
        setSearchBarBorder(color: .clear)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = "" // Xóa nội dung khi người dùng nhấn Cancel
           searchBar.resignFirstResponder() // Ẩn bàn phím
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text, !searchText.isEmpty {
                print("User searched for: \(searchText)") // In ra nội dung tìm kiếm
                // Thực hiện hành động tìm kiếm hoặc xử lý nội dung tìm kiếm tại đây
            }
            searchBar.resignFirstResponder() // Ẩn bàn phím sau khi nhấn tìm kiếm
    }
    
    func setSearchBarBorder(color: UIColor) {
           if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
               searchTextField.layer.borderColor = color.cgColor
               searchTextField.layer.borderWidth = 1.0 // Độ dày của viền
               searchTextField.layer.cornerRadius = 19 // Bo góc cho trường tìm kiếm
               searchTextField.layer.masksToBounds = true
               let imageView = UIImageView(image: UIImage(named: "Search"))
               imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
               searchTextField.leftView = imageView
               searchTextField.leftViewMode = .always
           }
       }

}



struct HomeResponse: Codable {
  struct Segmented: Codable {
    let id: Int?
    let title: String?
  }

  struct Data: Codable {
    struct Popular: Codable {
      let userID: Int?
      let userName: String?
      let userImage: String?
      let onlineStatus: String?
      let statusImage: String?
      let commentCount: Int?
      let likeCount: Int?

      private enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName
        case userImage
        case onlineStatus
        case statusImage
        case commentCount
        case likeCount
      }
    }

    struct Trending: Codable {
      let userID: Int?
      let userName: String?
      let userImage: String?
      let onlineStatus: String?
      let statusImage: String?
      let commentCount: Int?
      let likeCount: Int?

      private enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName
        case userImage
        case onlineStatus
        case statusImage
        case commentCount
        case likeCount
      }
    }

    struct Following: Codable {
      let userID: Int?
      let userName: String?
      let userImage: String?
      let onlineStatus: String?
      let statusImage: String?
      let commentCount: Int?
      let likeCount: Int?

      private enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName
        case userImage
        case onlineStatus
        case statusImage
        case commentCount
        case likeCount
      }
    }

    let popular: [Popular]?
    let trending: [Trending]?
    let following: [Following]?

    private enum CodingKeys: String, CodingKey {
      case popular = "Popular"
      case trending = "Trending"
      case following = "Following"
    }
  }

  let segmented: [Segmented]?
  let data: Data?
}
@available(iOS 17.0, *)
#Preview {
    HomeViewController()
}
