//
//  CustomCollectionViewCell.swift
//  Spotify
//
//  Created by Yerkebulan on 15.09.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    public static let identifier = "CustomCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
