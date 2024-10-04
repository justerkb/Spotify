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
    
    private let clientId     = "ad083730a3444de6871301650234b14d"
    private let clientSecret = "712375219eea466eb0a67929bf9f4408"
    private let redirectURI  = "https://www.iosacademy.io"
    private let yourScopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email%20user-top-read"
    private let tokenAPIURL  = "https://accounts.spotify.com/api/token"

        
    private init() {}

    public func getBaseToken() -> String {
        return "\(clientId):\(clientSecret)"
    }
    
    public var signInURL: String {
        let string = "https://accounts.spotify.com/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)&scope=\(yourScopes)&show_dialog=FALSE"
        return string
    }
    
    
    public var isSignedIn: Bool {
        return TokenManager.shared.hasValidToken
//        return false
    }
    
    func refreshCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: tokenAPIURL) else { return }
        
        var request = URLRequest(url: url)
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectURI)
        ]
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody   = urlComponents.query?.data(using: .utf8)
        let baseToken = "\(clientId):\(clientSecret)"
        
        guard let data = baseToken.data(using: .utf8) else {
            print("failure to converty basetoken to data")
            completion(false)
            return
        }
        
        let encodedString = data.base64EncodedString()
        
        request.setValue("Basic \(encodedString)", forHTTPHeaderField: "Authorization")
        
        
        
        let task = URLSession.shared.dataTask(with: request) { [weak self ] data, responce, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(AuthRequest.self, from: data)
                TokenManager.shared.cacheToken(authRequest: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
            
        }
        task.resume()
    }
}



