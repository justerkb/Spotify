//
//  Playlist.swift
//  Spotify
//
//  Created by Yerkebulan on 13.09.2024.
//

import Foundation
struct Playlist: Codable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrl
    let href: String
    let id: String
    let images: [Image]?
    let name: String
}
