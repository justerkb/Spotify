//
//  UserPlaylist.swift
//  Spotify
//
//  Created by Yerkebulan on 13.09.2024.
//

import Foundation
struct PlaylistResponce: Codable {
    let href: String
    let total: Int
    let items: [Playlist]
}
