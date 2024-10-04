import Foundation
import UIKit

class RecomendedTracks: UICollectionViewCell {
     
    
    var name: UILabel = {
        let label = UILabel()
        label.text = "unknown"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    var image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "spotify-icon-36865"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    static let reuseIdentifier: String = "FeaturedPlaylistCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Stack view для размещения имени и картинки горизонтально
        let stackView = UIStackView(arrangedSubviews: [image, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8 // Отступ между текстом и изображением
        
        contentView.addSubview(stackView)
        contentView.layer.cornerRadius = 15
        // Ограничения для stackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Ограничение ширины изображения
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with playlsit: RecomendedTracksCellViewModel) {
        name.text = playlsit.name
        if let imageUrl = playlsit.image {
            NetworkManager.shared.loadImage(url: imageUrl) { data in
                DispatchQueue.main.sync {
                    self.image.image = UIImage(data: data!)
                }
            }

        }
    }
}

