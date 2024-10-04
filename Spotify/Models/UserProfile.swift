//
//  UserProfile.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
struct UserProfile: Codable {
    let country: String
    let displayName: String
    let email: String
    let href: String?
    let id: String
    let images: [Image]
    let product: String
    let uri: String
}



