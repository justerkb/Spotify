//
//  HeaderView.swift
//  Spotify
//
//  Created by Yerkebulan on 10.09.2024.
//

import UIKit

class HeaderView: UIView {
    private let topPadding: CGFloat  = 10
    private let leftPadding: CGFloat = 15
    
    private let righItem: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let viewProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
        label.text = "View Profile"
        return label
    }()
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "yerko"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatar)
        self.addSubview(username)
        self.addSubview(righItem)
        self.addSubview(viewProfileLabel)
        
        let avatarSize = self.bounds.height - topPadding * 2
        
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: avatarSize),
            avatar.heightAnchor.constraint(equalToConstant: avatarSize),
            
            avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            username.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: leftPadding),
            username.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -3),
            
            viewProfileLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: leftPadding),
            viewProfileLabel.topAnchor.constraint(equalTo: avatar.centerYAnchor, constant: 3),
            
            righItem.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            righItem.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            righItem.widthAnchor.constraint(equalToConstant: 20),
            righItem.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        avatar.layer.cornerRadius = avatar.bounds.width / 2
    }
    
    public func configure(imageData: Data) {
        avatar.image = UIImage(data: imageData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
