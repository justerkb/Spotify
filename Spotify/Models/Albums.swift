//
//  Albums.swift
//  Spotify
//
//  Created by Yerkebulan on 12.09.2024.
//

import Foundation
struct Albums: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Album]
}
