//
//  TokenManager.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
class TokenManager {
    private init() {}
    
    public static let shared = TokenManager()
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "Acces-Token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "Refresh-Token")
    }
    
    public func refreshAccesToken(completion: @escaping (Bool) -> Void) {
        
        guard let refreshToken = refreshToken else {
            print("no refresh token")
            completion(false)
            return
        }
        
        let tokenAPIURL = "https://accounts.spotify.com/api/token"
        
        guard let url = URL(string: tokenAPIURL) else {
            print("url")
            return
        }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value:  refreshToken),
        ]
        
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let baseToken = AuthManager.shared.getBaseToken()
        guard let data = baseToken.data(using: .utf8) else {
            print("failure to converty basetoken to data")
            completion(false)
            return
        }
        
        let encodedString = data.base64EncodedString()
        
        request.setValue("Basic \(encodedString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data, error == nil else {
                print("data is nil error is not nil")
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(AuthRequest.self, from: data)
                self.cacheToken(authRequest: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
        }
        task.resume()
        
    }
    
    public func refreshTokenIfNeeded() {
        
        if isExpiredToken {
            refreshAccesToken { succes in
                if succes {
                    print("succefully updated refresh token")
                    
                } else {
                    print("something went wrong during updating accesToken")
                }
            }
        } else {
            print("Token is not expired")
        }
    }
    
    public func getValidAccesToken() -> String? {
        refreshTokenIfNeeded()
        
        print(self.accessToken)
        return self.accessToken
    }
    
    public var hasValidToken: Bool {
        return accessToken != nil
    }
    
    public var isExpiredToken: Bool {

        if let expirationDate = UserDefaults.standard.object(forKey: "expiresIn") as? Date {
            return Date.now > expirationDate
        }
        print("key not found")
        return true
    }
    
    public func cacheToken(authRequest: AuthRequest) {
        UserDefaults.standard.set(authRequest.accessToken, forKey: "Acces-Token")
        if let refreshToken = authRequest.refreshToken {
            UserDefaults.standard.set(refreshToken, forKey: "Refresh-Token")
        }
        UserDefaults.standard.set(Date.now.addingTimeInterval(Double(authRequest.expiresIn)), forKey: "expiresIn")
    }
    
}
