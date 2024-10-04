//
//  PlaylistResponce.swift
//  Spotify
//
//  Created by Yerkebulan on 14.09.2024.
//

import Foundation
struct PlaylistsResponce: Codable {
    let items: [Playlist]
    let href: String
}
