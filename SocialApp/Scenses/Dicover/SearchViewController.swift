//
//  SearchViewController.swift
//  SocialApp
//
//  Created by Andy on 05/10/2024.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    lazy var contentVstack = UIStackView(frame: .zero)
        .with(\.axis, setTo: .vertical)
        .with(\.spacing, setTo: 20)
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        return searchBar
    }()
    
    lazy var tableView = UITableView(frame: .zero)
        .with(\.separatorStyle, setTo: .none)
    
    var originalData: [TopicResponse.Topic]
    
    
    var filterData: [TopicResponse.Topic] {
        didSet {
            tableView.reloadData()
        }
    }
   
    init(topic: [TopicResponse.Topic]) {
        self.originalData = topic
        self.filterData = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setSearchBarBorder(color: .clear)
        
        /*
        title = "Search View Controller"
        navigationController?.navigationBar.prefersLargeTitles = true
        */
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(contentVstack)
        contentVstack.addArrangedSubviews([searchBar, tableView])
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        contentVstack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(37)
        }
        searchBar.delegate = self
        
        /*
         // pop 1 màn
         navigationController?.popViewController(animated: true)
         
         // pop về màn đầu tiên
         navigationController?.popToRootViewController(animated: true)
        
        // Pop to viewcontroller
        if let searchVC = navigationController?.viewControllers.first(where: { $0 is SearchViewController }) {
            navigationController?.popToViewController(searchVC, animated: true)
        }
        
        // set mảng viewcontrollers
        let viewController1 = UIViewController()
        let viewController2 = UIViewController()
        let viewController3 = UIViewController()
        
        navigationController?.setViewControllers([viewController1, viewController2, viewController3], animated: true)
        */
    }
    
    func setSearchBarBorder(color: UIColor) {
           if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
               searchTextField.layer.borderColor = color.cgColor
               searchTextField.layer.borderWidth = 1.0 // Độ dày của viền
               searchTextField.layer.cornerRadius = 18 // Bo góc cho trường tìm kiếm
               searchTextField.layer.masksToBounds = true
               let imageView = UIImageView(image: UIImage(named: "Search"))
               imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
               searchTextField.leftView = imageView
               searchTextField.leftViewMode = .always
           }
       }
    
    func searchText(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text {
          filterData = originalData.filter { topic in
              return topic.title?.lowercased().contains(keyword.lowercased()) ?? false
            }
        } else {
            filterData = originalData
        }
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = "Type something"
        setSearchBarBorder(color: UIColor(hexString: "5151C6"))
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchText(searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = "" // Xóa nội dung khi người dùng nhấn Cancel
        searchBar.resignFirstResponder() // Ẩn bàn phím
        filterData = originalData
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // Ẩn bàn phím sau khi nhấn tìm kiếm
        searchText(searchBar)
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return .init() }
        let topic = filterData[indexPath.row]
        if let urlString = topic.image {
            cell.collectImg.kf.setImage(with: URL(string: urlString))
        }
        cell.lblCollectTitle.text = topic.title
        cell.lblCollectTitle.textAlignment = indexPath.row % 2 == 0 ? .left : .right
      
         return cell
    }
    
    
}

