//
//  TopArtistsHeader.swift
//  Spotify
//
//  Created by Yerkebulan on 07.10.2024.
//

import Foundation
import UIKit

class TopArtistsHeader: UICollectionReusableView {
    static let reuseIdentifier = "TopArtistsHeader"

    let headerTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Your favourite artists"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .red
        self.addSubview(headerTitle)
        
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: self.topAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
