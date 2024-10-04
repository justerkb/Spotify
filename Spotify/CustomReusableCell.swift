//
//  CustomReusableCell.swift
//  Spotify
//
//  Created by Yerkebulan on 15.09.2024.
//

import UIKit

class CustomReusableCell: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "I will ios developer"
        label.backgroundColor = .blue
        
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
