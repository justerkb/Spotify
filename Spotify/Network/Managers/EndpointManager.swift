//
//  EndpointManager.swift
//  Spotify
//
//  Created by Yerkebulan on 12.09.2024.
//

import Foundation


class EndpointManager {
    private init() {}
    
    public static let shared = EndpointManager()
    
    private let baseUrl = "https://api.spotify.com/v1"
    
    enum Endpoint: String {
        
        case newReleases = "/browse/new-releases"
        case userPlaylists = "/me/playlists"
        case featuredPlaylists = "/browse/featured-playlists"
        case recommendations = "/recommendations"
        case genres = "/recommendations/available-genre-seeds"
        case topArtists = "/me/top/artists"
        
    }
    
    public func getEndPoint(for endpoint: Endpoint)-> String {
        return baseUrl + endpoint.rawValue
    }
    
}
