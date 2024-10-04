//
//  UserPlaylistsSectionCell.swift
//  Spotify
//
//  Created by Yerkebulan on 29.09.2024.
//

import UIKit

class UserPlaylistsSectionCell: UICollectionViewCell {
    let name = UILabel()
    let image = UIImageView()
    public static let reuseIdentifier = "UserPlaylistsSectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [image, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .horizontal
        self.addSubview(stackView)
        self.backgroundColor = .systemGray6
//        stackView.backgroundColor = .white
        stackView.distribution = .fill
    
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with playlist: UserPlaylistsCellViewModel) {
        name.text = "unkown"
        if let imageUrl = playlist.image {
            NetworkManager.shared.loadImage(url: imageUrl) { data in
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: data!)
                }
            }

        }
    }
    
    
}
