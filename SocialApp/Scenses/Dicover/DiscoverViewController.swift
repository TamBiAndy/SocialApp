//
//  DiscoverViewController.swift
//  SocialApp
//
//  Created by Andy on 23/09/2024.
//

import UIKit

class DiscoverViewController: UIViewController {

//    lazy var topHstack = UIStackView(frame: .zero)
//        .with(\.spacing, setTo: 16)
//    
//    lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.placeholder = "Search"
//        searchBar.searchBarStyle = .minimal
//        searchBar.showsCancelButton = false
//        return searchBar
//    }()
//    
//    lazy var btnSendCopy: UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.backgroundColor = UIColor(hexString: "F6F7F9")
//        btn.setImage(UIImage(named: "Send copy"), for: .normal)
//        btn.layer.cornerRadius = 18
//        return btn
//    }()
//    let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    
    lazy var topicView = TopicView()
    
    lazy var collectionView = CollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupNaviBar()
       
    }
    
    private func setupView() {
        view.addSubViews([topicView, collectionView, UIView()])
//        topHstack.addArrangedSubviews([searchBar, btnSendCopy])
        
//        topHstack.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//        }
//        
//        btnSendCopy.snp.makeConstraints { make in
//            make.height.width.equalTo(36)
//        }
//        
//        searchBar.snp.makeConstraints { make in
//            make.height.equalTo(37)
//        }
        
        topicView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(31)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(146)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topicView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(231)
        }
//        searchBar.delegate = self
   
    }
    
    private func setupNaviBar() {
//        navigationItem.searchController = searchController
//        searchController.searchBar.delegate = self
//        searchController.searchBar.placeholder = "Search"
//        searchController.searchBar.searchBarStyle = .minimal
//        searchController.searchBar.showsCancelButton = false
//        definesPresentationContext = true
//        setSearchBarBorder(color: .clear)
        
      
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
        
        setSearchBarBorder(color: .clear)
        
        navigationItem.titleView = searchBar
        
        let sendBtnItem = UIBarButtonItem(
            image: UIImage(named: "Send copy"),
            style: .done,
            target: self,
            action: #selector(clickToSend)
            )
        navigationItem.rightBarButtonItem = sendBtnItem
            
    }
            
    @objc func clickToSend() {
        print("Sent Tapped")
    }

}

extension DiscoverViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = "Type something"
        setSearchBarBorder(color: UIColor(hexString: "5151C6"))
        searchBar.setShowsCancelButton(true, animated: true)
        
        let searchVC = SearchViewController(topic: topicView.topicResponse)
        navigationController?.pushViewController(searchVC, animated: true)
        searchBar.resignFirstResponder()
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

