//
//  AuthManager.swift
//  Spotify
//
//  Created by Yerkebulan on 21.08.2024.
//

import Foundation
import SpotifyiOS


class AuthManager {
    
    static let shared = AuthManager()
    
    public let clientId     = "ad083730a3444de6871301650234b14d"
    public let clientSecret = "712375219eea466eb0a67929bf9f4408"
    public let redirectURI  = "https://www.iosacademy.io"
    public let yourScopes   = "user-read-private"
    public let tokenAPIURL  = ""
    
    private init() {}
    
    private var accessToken: String? {
        didSet {
            // Save the access token securely, e.g., in the Keychain
        }
    }
    
    public var signInURL: String {
        let string = "https://accounts.spotify.com/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)&scope=\(yourScopes)&show_dialog=FALSE"
        return string
    }
    
    private var refreshToken: String? {
        didSet {
            // Save the refresh token securely, e.g., in the Keychain
        }
    }
    
    public var isSignedIn: Bool {
        return false
    }
    
    public func signOut() {
        accessToken = nil
        refreshToken = nil
        // Remove tokens from secure storage (e.g., Keychain)
    }
    
    func refreshCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        
    }
    
}



