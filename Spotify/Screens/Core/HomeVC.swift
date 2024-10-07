//
//  ViewController.swift
//  Spotify
//
//  Created by Yerkebulan on 20.08.2024.
//

import UIKit
enum BrowseSectionType {
    case userPlaylists(models: [UserPlaylistsCellViewModel])
    case topArtists(models: [TopArtistsCellViewModel])
    case recomendedTracks(models: [RecomendedTracksCellViewModel])
}

class HomeVC: UIViewController {
    public static let categoryHeaderId = "categoryHeaderId"
    public static let headerId = "headerId"
    
    private var collectionView: UICollectionView!
        
    private var sections = [BrowseSectionType]()
                                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        title = "Home"
        view.backgroundColor = .primary
        self.navigationItem.backButtonTitle = " "
        setupCollectionView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didDapLeftBar))
    
        fetchData()
    }
    
    @objc func didDapLeftBar() {
        let vc = SettingsVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var recomendations: Recommendations?
        var userPlaylists: PlaylistsResponce?
        var userTopArtists: UserTopItems?

        NetworkManager.shared.getGenres { genres in
            switch genres {
            case .success(let genresResponse):
                let genres = genresResponse.genres
                var seeds  = [String]()
                while seeds.count < 2 {
                    seeds.append(genres.randomElement()!)
                }
                print(seeds.joined(separator: ","))
                NetworkManager.shared.getRecommendations(genres: seeds.joined(separator: ",")) { result in
                    defer {
                        group.leave()
                    }
                    switch result {
                    case.success(let model):
                        recomendations = model
                    case.failure(let error):
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        NetworkManager.shared.getCurrentUserPlaylists { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                userPlaylists = model
            case.failure(let error):
                print(error)
            }
        }
        
        NetworkManager.shared.getTopArtists { result in
            defer {
                group.leave()
            }
            switch result {
            case.success(let model):
                userTopArtists = model
            case.failure(let error):
                print(error)
            }
    
        }
        
        group.notify(queue: .main) { [self] in
            guard let recomendedTracks  = recomendations?.tracks,
                  let userTopArtists    = userTopArtists?.items,
                  let userPlaylists     = userPlaylists?.items
            else {
                return
            }
            
            self.configureModels(recomendedTracks: recomendedTracks, userTopArtists: userTopArtists, userPlaylists: userPlaylists)
            
            self.collectionView.reloadData()
            print(recomendedTracks.count)
        }
    }
    
    private func configureModels(recomendedTracks: [Track], userTopArtists: [Artist], userPlaylists: [Playlist]) {
        sections.append(.userPlaylists(models: userPlaylists.compactMap({
            return UserPlaylistsCellViewModel(name: $0.name, image: $0.images?[0].url)
        })))
        sections.append(.topArtists(models:userTopArtists.compactMap({
            return TopArtistsCellViewModel(name: $0.name, image: $0.images[0].url)
        })))
        sections.append(.recomendedTracks(models:recomendedTracks.compactMap({
            return RecomendedTracksCellViewModel(name: $0.name, image: $0.album.images[0].url)
        })))
        
    }
    
    public func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.register(CustomReusableCell.self, forSupplementaryViewOfKind: HomeVC.categoryHeaderId, withReuseIdentifier: HomeVC.headerId)
        collectionView.register(RecomendedTracksSectionCell.self, forCellWithReuseIdentifier: RecomendedTracksSectionCell.reuseIdentifier)
        collectionView.register(UserPlaylistsSectionCell.self, forCellWithReuseIdentifier: UserPlaylistsSectionCell.reuseIdentifier)
        collectionView.register(TopArtistsSectionCell.self, forCellWithReuseIdentifier: TopArtistsSectionCell.reuseIdentifier)
        collectionView.register(TopArtistsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TopArtistsHeader.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            switch section {
            case 0:
                return self?.createUserPlaylistsSection()
            case 1:
                return self?.createTopArtistsSection()
            default:
                return self?.createRecomendedTracks()
            }
        }
        return layout
    }
    
    //MARK: - Sections
    private func createUserPlaylistsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    
        layoutItem.contentInsets.trailing = 10
        layoutItem.contentInsets.bottom = 10


        let layoutHorizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.25))
        
        let layoutVerticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let horizontalLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutHorizontalGroupSize, subitems: [layoutItem])
        
        let verticalLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutVerticalGroupSize, subitems: [horizontalLayoutGroup])
        let layoutSection = NSCollectionLayoutSection(group: verticalLayoutGroup)
        
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.contentInsets.leading  = 15
        layoutSection.contentInsets.trailing = 5
        layoutSection.contentInsets.bottom   = 30
        
        return layoutSection
    }
    
    private func createTopArtistsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        layoutItem.contentInsets.leading = 5
        layoutItem.contentInsets.bottom = 5
        layoutItem.contentInsets.trailing = 5
        
        let layoutHorizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalWidth(0.5))
        let horizontalLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutHorizontalGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: horizontalLayoutGroup)

        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets.bottom = 15
        
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    
    private func createRecomendedTracks() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        layoutItem.contentInsets.leading = 5
        layoutItem.contentInsets.bottom = 5
        layoutItem.contentInsets.trailing = 5
        
    
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(0))
        let verticalLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: verticalLayoutGroup)
        
        layoutSection.contentInsets.bottom = 15

        return layoutSection
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

//MARK: - CollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .userPlaylists(let models):
            return models.count
        case .topArtists(let models):
            return models.count
        case .recomendedTracks(let models):
            return models.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !sections.isEmpty {
            let section = sections[indexPath.section]
            
            
            switch section {
            case .topArtists(let models):
                let model = models[indexPath.item]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopArtistsSectionCell.reuseIdentifier, for: indexPath) as? TopArtistsSectionCell
                cell?.configure(with: model)
                return cell!
            case .recomendedTracks(let models):
                let model = models[indexPath.item]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedTracksSectionCell.reuseIdentifier, for: indexPath) as? RecomendedTracksSectionCell
                cell?.configure(with: model)
                return cell!
            case .userPlaylists(let models):
                let model = models[indexPath.item]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPlaylistsSectionCell.reuseIdentifier, for: indexPath) as? UserPlaylistsSectionCell
                cell?.configure(with: model)
                return cell!
            }
        } else {
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
                emptyCell.backgroundColor = .gray
            return emptyCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TopArtistsHeader.reuseIdentifier, for: indexPath) as! TopArtistsHeader
        
        return header
    }
    
}

#Preview {
    UINavigationController(rootViewController: HomeVC())
}
