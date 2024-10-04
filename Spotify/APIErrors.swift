//
//  APIErrors.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
enum APIErrors: Error {
    
    case noWiFi
    case failedToGetData
    case invalidResponse
    case decodingFailed
    case unknown
    case invalidUrl
    case clientSideError(errorMessage: String)
    case serverError(statusCode: Int)
    
}
