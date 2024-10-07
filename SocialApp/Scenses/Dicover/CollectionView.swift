//
//  CollectionView.swift
//  SocialApp
//
//  Created by Andy on 30/09/2024.
//

import UIKit
import Moya
import Kingfisher

class CollectionView: UIView {
    
    let provider = MoyaProvider<APITarget>()
    
    lazy var titleHstack = UIStackView(frame: .zero)
    
    lazy var lblTitle = UILabel(frame: .zero)
        .with(\.text, setTo: "Collection")
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
        flowLayout.itemSize = .init(width: 158, height: 185)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    var collectionResponse: [CollectionResponse.Collection] = [] {
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
        provider.request(.getCollectionDiscovery) { result in
            switch result {
                
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                do {
                    let collectionResponse = try decoder.decode(CollectionResponse.self, from: response.data)
                    self.collectionResponse = collectionResponse.collection ?? []
                    let statusCode = response.statusCode
                    
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
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        titleHstack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleHstack.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(185)
        }
    }

}

extension CollectionView: UICollectionViewDelegate {
    
}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return .init() }
        let collection = collectionResponse[indexPath.row]
        let urlString = URL(string: collection.image ?? "")
        cell.collectionImg.kf.setImage(with: urlString)
        cell.lblCollection.text = collection.title
        cell.lblQuantity.text = collection.quantity
        return cell
    }
    
    
}

struct CollectionResponse: Codable {
  struct Collection: Codable {
    let id: Int?
    let image: String?
    let title: String?
    let quantity: String?
  }

  let id: Int?
  let collection: [Collection]?
}

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    lazy var collectionImg = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.layer.cornerRadius, setTo: 10)
        .with(\.clipsToBounds, setTo: true)
    
    lazy var lblCollection = UILabel(frame: .zero)
        .with(\.text, setTo: "Photography")
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .bold))
        .with(\.textColor, setTo: .white)
        .with(\.numberOfLines, setTo: 0)
        .with(\.textAlignment, setTo: .center)
    
    lazy var lblQuantity = UILabel(frame: .zero)
        .with(\.text, setTo: "70 Photos")
        .with(\.font, setTo: .systemFont(ofSize: 14, weight: .ultraLight))
        .with(\.textColor, setTo: UIColor(hexString: "828282"))
        .with(\.numberOfLines, setTo: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        contentView.addSubViews([collectionImg, lblCollection, lblQuantity])
        
        collectionImg.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.height.width.equalTo(158)
        }
        
        lblCollection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
        }
        
        lblQuantity.snp.makeConstraints { make in
            make.top.equalTo(collectionImg.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalToSuperview()
        }
    }
}

