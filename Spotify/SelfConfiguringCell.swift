//
//  SelfConfiguringCell.swift
//  Spotify
//
//  Created by Yerkebulan on 27.09.2024.
//

import Foundation
protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with playlsit: BrowseSectionType)
}
