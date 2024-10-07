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
        
       
        contentView.addSubview(name)
        contentView.addSubview(image)
        name.textAlignment = .left
        self.backgroundColor = .systemGray5
        name.font = .systemFont(ofSize: 16, weight: .bold)
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        

            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with playlist: UserPlaylistsCellViewModel) {
        name.text = playlist.name
        if let imageUrl = playlist.image {
            NetworkManager.shared.loadImage(url: imageUrl) { data in
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: data!)
                }
            }

        }
    }
    
    
}
