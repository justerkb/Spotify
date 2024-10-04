//
//  AuthRequest.swift
//  Spotify
//
//  Created by Yerkebulan on 05.09.2024.
//

import Foundation
struct AuthRequest: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
}
