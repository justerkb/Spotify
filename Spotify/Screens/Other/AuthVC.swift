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
            self?.handleCompletion(success)
        }
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let urlComponents = URLComponents(string: url) else { return nil }
        return urlComponents.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func handleCompletion(_ success: Bool) {
        
    }
}
