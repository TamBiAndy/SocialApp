//
//  TopicView.swift
//  SocialApp
//
//  Created by Andy on 24/09/2024.
//

import UIKit
import Moya
import Kingfisher

class TopicView: UIView {
    
    let provider = MoyaProvider<APITarget>()
    
    lazy var titleHstack = UIStackView(frame: .zero)
    
    lazy var lblTitle = UILabel(frame: .zero)
        .with(\.text, setTo: "Topic")
        .with(\.font, setTo: .systemFont(ofSize: 20, weight: .bold))
        .with(\.textColor, setTo: UIColor(hexString: "212121"))
    
    lazy var btnViewmore: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("View more", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .ultraLight)
        btn.setTitleColor(UIColor(hexString: "5151C6"), for: .normal)
        return btn
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 150, height: 100)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    var topicResponse: [TopicResponse.Topic] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fetchingData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchingData() {
        provider.request(.getTopicDiscovery) { result in
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                do {
                    let topicResponse = try decoder.decode(TopicResponse.self, from: response.data)
                    self.topicResponse = topicResponse.topic ?? []
                } catch {
                    print(error)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func setupView() {
        self.addSubViews([titleHstack, collectionView, UIView()])
        titleHstack.addArrangedSubviews([lblTitle, UIView(), btnViewmore])
        
        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        titleHstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleHstack.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

extension TopicView: UICollectionViewDelegate {
    
}

extension TopicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topicResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as? TopicCollectionViewCell else { return .init() }
        let topic = topicResponse[indexPath.row]
        let urlString = URL(string: topic.image ?? "")
        cell.topicImg.kf.setImage(with: urlString)
        cell.lblTopic.text = topic.title
        return cell
    }
    
    
}

struct TopicResponse: Codable {
  struct Topic: Codable {
    let id: Int?
    let image: String?
    let title: String?
  }

  let id: Int?
  let topic: [Topic]?
}

class TopicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TopicCollectionViewCell"
    
    lazy var topicImg = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.layer.cornerRadius, setTo: 10)
        .with(\.clipsToBounds, setTo: true)
    
    lazy var lblTopic = UILabel(frame: .zero)
        .with(\.text, setTo: "Photography")
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .bold))
        .with(\.textColor, setTo: .white)
        .with(\.numberOfLines, setTo: 0)
        .with(\.textAlignment, setTo: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        contentView.addSubViews([topicImg, lblTopic])
        
        topicImg.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        
        lblTopic.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            
        }
    }
}


