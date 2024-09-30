//
//  NetworkManager.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
import UIKit
class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Constants
    private let baseEndpoint
    
    //MARK: - API Calls
    
    public func getUserProfile(completiion: @escaping(Result<UserProfile, APIErrors>) -> Void) {
        let endpoint = "https://api.spotify.com/v1/me"
        guard let url = URL(string: endpoint) else {
            return
        }
        
        createRequest(
            with: url, 
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, responce, error in
                guard let data = data else {
                    completiion(.failure(.noWiFi))
                    return
                }
                
                if let error = error {
                    print(error.localizedDescription)
                    completiion(.failure(.noWiFi))
                    return
                }
                
                //cheking for api responce
    //            if let responce = responce {
    //                guard let responce as? HTTPURLResponse else {
    //
    //                }
    //                print(responce.statu)
    //            }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let result = try decoder.decode(UserProfile.self, from: data)
                    completiion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completiion(.failure(.decodingFailed))
                }
            }
            task.resume()
        }
        
    }
    
    public func loadImage(url: String, completion: @escaping(Data?) -> Void) {
        guard let url = URL(string: url) else {
            print("unable to create URL from the string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("unable create data")
                return
            }
            
            completion(data)
        }
        task.resume()
        
    }
    
    public func getNewReleases(completion: @escaping (Result<Albums, APIErrors>) -> Void) {
        
    }
    
    
    //MARK: - Private
    private func createRequest(with url: URL, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        guard let accessToken = TokenManager.shared.getValidAccesToken() else {
            return
        }
        
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(request)
    }
    
    
    //MARK: - Enums
    enum HTTPMethod: String {
        case GET
        case POST
    }
}
