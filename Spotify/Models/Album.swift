//
//  items.swift
//  Spotify
//
//  Created by Yerkebulan on 12.09.2024.
//

import Foundation
enum AlbumType: String, Codable {
    case album = "album"
    case single = "single"
    case compilation = "compilation"
}

struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let externalUrls: ExternalUrl
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String
}


