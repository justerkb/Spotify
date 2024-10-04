//
//  SCSpotifyCell.swift
//  Spotify
//
//  Created by Yerkebulan on 10.09.2024.
//

import UIKit

class SettingsOptionCell: UITableViewCell {

    public static let identifier = "SettingsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Unknown"
        return label
    }()
    
    private let righItem: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .primary
        contentView.addSubview(titleLabel)
        contentView.addSubview(righItem)
        
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            righItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            righItem.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            righItem.widthAnchor.constraint(equalToConstant: 20),
            righItem.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    public func configure(title: String) {
        self.titleLabel.text = title
    }
    
}
