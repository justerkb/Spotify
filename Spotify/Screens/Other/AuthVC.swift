//
//  AuthVC.swift
//  Spotify
//
//  Created by Yerkebulan on 21.08.2024.
//

import UIKit
import WebKit

class AuthVC: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.frame = view.bounds
        
        loadAuthURL()
    }

    func loadAuthURL() {
        if let url = URL(string: AuthManager.shared.signInURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url?.absoluteString else { return }
        
        guard let code = getQueryStringParameter(url: url, param: "code") else {
            return
        }
        
        print(code)
        
        webView.isHidden = true
        
        AuthManager.shared.refreshCodeForToken(code: code) { [weak self] success in
            self?.handleSignIn(succes: success)
        }
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let urlComponents = URLComponents(string: url) else { return nil }
        return urlComponents.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func handleCompletion(_ success: Bool) {
        
    }
    
    func handleSignIn(succes: Bool) {
        if succes {
            DispatchQueue.main.async {
                
                let tabBar = TabBarController()
                tabBar.modalPresentationStyle = .fullScreen
                
                
                self.present(tabBar, animated: true)
                    
                NetworkManager.shared.getUserProfile { result in
                    switch result {
                    case.success(let userProfile):
                        UserDefaults.standard.set(userProfile.displayName, forKey: "Name")
                        
                        guard let imageUrl = userProfile.images.first?.url else {
                            print("user doesnt have image avatar")
                            return
                        }
                        
                        UserDefaults.standard.set(imageUrl, forKey: "AvatarUrl")
                        
                        NetworkManager.shared.loadImage(url: imageUrl) { dataImage in
                           if let dataImage = dataImage {
                               UserDefaults.standard.set(dataImage, forKey: "AvatarImage")
                           }
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                        
                }
            
                guard let imageUrl = UserDefaults.standard.string(forKey: "AvatarUrl") else {
                    print("cant find avatar url")
                    return
                }
                
                
                 NetworkManager.shared.loadImage(url: imageUrl) { dataImage in
                    if let dataImage = dataImage {
                        print("jkl")
                        UserDefaults.standard.set(dataImage, forKey: "AvatarImage")
                    }
                }
                
                
            }
        } else {
            print("something went wrong...")
        }
    }
}


