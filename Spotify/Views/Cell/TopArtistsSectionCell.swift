//
//  TopArtistsSectionCell.swift
//  Spotify
//
//  Created by Yerkebulan on 04.10.2024.
//

import Foundation
import UIKit

class TopArtistsSectionCell: UICollectionViewCell {
    public static let reuseIdentifier = "topArtistsSectionCell"
    let image = UIImageView(image: UIImage(named: "spotify-icon-36865"))
    let name  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        contentView.addSubview(name)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.masksToBounds = true
        
        name.text = "unkown"
        name.textAlignment = .center
        name.font = .systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: image.trailingAnchor),
        ])
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 76
        image.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with topArtist: TopArtistsCellViewModel) {
        name.text = topArtist.name
        if let imageUrl = topArtist.image {
            NetworkManager.shared.loadImage(url: imageUrl) { data in
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: data!)
                }
            }
        }
    }
}


