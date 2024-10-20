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
    
    let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    //MARK: - API Calls
    public func getUserProfile(completion: @escaping(Result<UserProfile, APIErrors>) -> Void) {
        let endpoint = "https://api.spotify.com/v1/me"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(
            with: url, 
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let result = try self.decoder.decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                    return
                }
            }
            task.resume()
        }
        
    }
    
    public func loadImage(url: String, completion: @escaping(Data?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let _ = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            completion(data)
        }
        task.resume()
        
    }
    
    public func getNewReleases(completion: @escaping (Result<NewRelases, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .newReleases) + "?limit=20&offset=0"
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, 
                      type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                
                    
                do {
                    let result = try self.decoder.decode(NewRelases.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
            
                }
            }
            task.resume()
        }
    }
    
    
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<PlaylistsResponce, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .userPlaylists) + "?limit=10&offset=0"
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {[weak self] data, responce, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try self.decoder.decode(PlaylistsResponce.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
                
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistResponce, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .featuredPlaylists) + "?limit=10&offset=0"
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try self.decoder.decode(FeaturedPlaylistResponce.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
        
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: String, completion: @escaping(Result<Recommendations, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .recommendations) + "?limit =50?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical,emo%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA"
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try self.decoder.decode(Recommendations.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
                
            }
            task.resume()
        }
    }
    
    public func getGenres(completion: @escaping (Result<GenresResponce, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .genres)
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let result = try self.decoder.decode(GenresResponce.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
            task.resume()
        }
    }

    public func getTopArtists(completion: @escaping(Result<UserTopItems, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .topArtists)
        
        guard let url = URL(string: endpoint) else  {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(with: url, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                    
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
//                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
//                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                    let result = try self.decoder.decode(UserTopItems.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
                
            }
            task.resume()
        }
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
    
    public func getRecents(completion: @escaping(Result<PlayHistoryResponce, APIErrors>) -> Void) {
        let endpoint = EndpointManager.shared.getEndPoint(for: .recentPlay)
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(
            with: url,
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    completion(.failure(.clientSideError(errorMessage: error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                
                if let httpResponce = responce as? HTTPURLResponse {
                    if httpResponce.statusCode != 200 {
                        completion(.failure(.serverError(statusCode: httpResponce.statusCode)))
                        return
                    }
                } else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let result = try self.decoder.decode(PlayHistoryResponce.self , from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                    return
                }
            }
            task.resume()
        }
        
    }
    
    //MARK: - Enums
    enum HTTPMethod: String {
        case GET
        case POST
    }
}
