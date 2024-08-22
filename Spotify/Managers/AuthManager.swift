//
//  AuthManager.swift
//  Spotify
//
//  Created by Yerkebulan on 21.08.2024.
//

import Foundation
class AuthManager {
    
    public static let shared = AuthManager()
    
    public class Constants {
        public static let clientId = "ad083730a3444de6871301650234b14d"
        public static let clientSecret = "712375219eea466eb0a67929bf9f4408"
    }
    
    private init() {}
    
    public var isSignedIn: Bool {
        return false
    }
}
