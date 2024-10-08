//
//  SegmentView.swift
//  SocialApp
//
//  Created by Andy on 04/10/2024.
//

import UIKit
import Kingfisher
import Moya

class SegmentView: UIView {
    
    let provider = MoyaProvider<APITarget>()
    
    lazy var segmentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var segmentControl: UISegmentedControl = {
       let segment = UISegmentedControl(items: ["Shots", "Collections"])
        segment.selectedSegmentIndex = 0
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segment.selectedSegmentTintColor = UIColor(hexString: "F1F1FE")

          let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "BDBDBD")]
        segment.setTitleTextAttributes(titleTextAttributes, for:.normal)

          let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "5151C6")]
        segment.setTitleTextAttributes(titleTextAttributes1, for:.selected)
       
    
        segment.addTarget(nil, action: #selector(segmentChanged), for: .valueChanged)
        
        return segment
    }()
    
    lazy var shotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var videoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        return view
    }()
    
//    lazy var shotFlowLayout: UICollectionViewFlowLayout = {
//       let flowLayout = UICollectionViewFlowLayout()
//        let screenWidth = (UIScreen.main.bounds.width - 54)
//        let cellWidth = screenWidth/2
//        flowLayout.itemSize = .init(width: cellWidth, height: cellWidth * 190/155)
//        flowLayout.scrollDirection = .vertical
//        flowLayout.minimumLineSpacing = 14
//        flowLayout.minimumInteritemSpacing = 14
//        return flowLayout
//    }()
    
    lazy var shotFlowLayout: UICollectionViewCompositionalLayout = {
        let flowLayout = creatShotFlowLayout()
        return flowLayout
    }()
    
    lazy var videoFlowLayout: UICollectionViewFlowLayout = {
       let flowLayout = UICollectionViewFlowLayout()
        let screenWidth = (UIScreen.main.bounds.width - 58)
        let cellWidth = screenWidth/2
        flowLayout.itemSize = .init(width: cellWidth, height: cellWidth * 185/158)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 18
        return flowLayout
    }()
    
    lazy var defaultImg = UIImageView(frame: .zero)
        .with(\.contentMode, setTo: .scaleToFill)
        .with(\.image, setTo: UIImage(named: "Group 6999"))
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: shotFlowLayout)

    var dataResponse: [Int: [Any]] = [:] {
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
        provider.request(.getUserCollection) { result in
            
            switch result {
                
            case .success(let response):
                
                let decoder = JSONDecoder()
                
                do {
                    let dataResponse = try decoder.decode(ShortNvideoResponse.self, from: response.data)
                    let shots = dataResponse.shot?.compactMap { $0 } ?? []
                    
                    self.dataResponse[0] = shots
                    self.segmentControl.setTitle("\(shots.count) shots", forSegmentAt: 0)
                    
                    let videos = dataResponse.video ?? []
                    self.dataResponse[1] = videos
                    
                    self.segmentControl.setTitle("\(videos.count) Collections", forSegmentAt: 1)
                } catch {
                    print(error)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func creatShotFlowLayout() -> UICollectionViewCompositionalLayout {
        let item1 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(190)
                             )
            
        )
        item1.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 8)
        
        let item2 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(190)
                             )
        )
        item2.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 8)
        
        let item3 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(65)
                             )
        )
        item3.contentInsets = .init(top: 7, leading: 0, bottom: 8, trailing: 8)
        
        
        let verticalGroup1 = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1/2),
                              heightDimension: .absolute(445)),
            subitems: [item1, item2, item3])
        verticalGroup1.contentInsets = .init(top: 0, leading: 7, bottom: 8, trailing: 0)
        
        let item4 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(100)
                             )
        )
        item4.contentInsets = .init(top: 0, leading: 7, bottom: 8, trailing: 0)
        
        let item5 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(155)
                             )
        )
        item5.contentInsets = .init(top: 0, leading: 7, bottom: 8, trailing: 0)
        
        let item6 = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(190)
                             )
        )
        item6.contentInsets = .init(top: 0, leading: 7, bottom: 8, trailing: 0)
        
        
        let verticalGroup2 = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1/2),
                              heightDimension: .absolute(445)),
            subitems: [item4, item5, item6]
        )
        verticalGroup2.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(1)),
            subitems: [verticalGroup1, verticalGroup2]
        )
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func setupView() {
        self.addSubViews([segmentView, collectionView])
        segmentView.addSubViews([segmentControl, shotView,videoView])
        
        collectionView.register(ShotCollectionViewCell.self, forCellWithReuseIdentifier: ShotCollectionViewCell.identifier)
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        segmentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        shotView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        videoView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
//        defaultImg.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.height.width.equalTo(180)
//        }
    }
    
    @objc func segmentChanged() {
        if segmentControl.selectedSegmentIndex == 0 {
            collectionView.setCollectionViewLayout(shotFlowLayout, animated: false)
        } else {
            collectionView.setCollectionViewLayout(videoFlowLayout, animated: false)
        }
        
        collectionView.reloadData()
    }
}

extension SegmentView: UICollectionViewDelegate {
    
}

extension SegmentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataResponse[segmentControl.selectedSegmentIndex]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShotCollectionViewCell.identifier, for: indexPath) as? ShotCollectionViewCell else { return .init() }
            if let shotResponse = dataResponse[0] as? [ShortNvideoResponse.Shot] {
               let urlString = shotResponse[indexPath.row].image
                cell.shotImgView.kf.setImage(with: URL(string: urlString ?? ""), placeholder: defaultImg as? Placeholder)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return .init() }
            if let videoResponse = dataResponse[1] as? [ShortNvideoResponse.Video] {
                let video = videoResponse[indexPath.row]
                let urlString = videoResponse[indexPath.row].image
                cell.collectImgView.kf.setImage(with: URL(string: urlString ?? ""), placeholder: defaultImg as? Placeholder)
                cell.lbllTitle.text = video.title
                cell.lblshotQty.text = video.videoQty
            }
            return cell
        }
    }
    
    
}

struct ShortNvideoResponse: Codable {
  struct Shot: Codable {
    let id: Int?
    let image: String?
  }

  struct Video: Codable {
    let title: String?
    let videoQty: String?
    let image: String?

    private enum CodingKeys: String, CodingKey {
      case title
      case videoQty = "video_Qty"
      case image
    }
  }

  let id: Int?
  let shot: [Shot]?
  let video: [Video]?
}

