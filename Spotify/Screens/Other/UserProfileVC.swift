//
//  UserProfileVC.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
import UIKit

class UserProfileVC: UIViewController {
    private lazy var bannerView: UIView = {
        let bview = UIView()
        bview.backgroundColor = .white
        bview.translatesAutoresizingMaskIntoConstraints = false
        bview.layer.cornerRadius = 15
        let title = UILabel()
        let body  = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        title.textColor = .black
        title.text = "No internet connection"
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        body.text  = "Turn mobile data or connect to Wi-Fi"
        body.textColor = .black
        body.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        body.text = "Turn on mobile data or connect to Wi-Fi"
        
        bview.addSubview(title)
        bview.addSubview(body)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: bview.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: bview.centerYAnchor),
            title.topAnchor.constraint(equalTo: bview.topAnchor, constant: 20),
            
            body.centerXAnchor.constraint(equalTo: bview.centerXAnchor),
            body.bottomAnchor.constraint(equalTo: bview.bottomAnchor, constant: -20),
            body.topAnchor.constraint(equalTo: bview.centerYAnchor)

        ])
        
    
        return bview
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "UserProfile"
        fetchProfile()
    }
     
    private func fetchProfile() {
        NetworkManager.shared.getUserProfile { [weak self] result in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let userProfile):
                    
                    self?.updateUI(with: userProfile)
                case .failure(let apiError):
                    
                    self?.failLoadUserProfile(apiError)
                    
                }
            }
        }
    }
    
    private func failLoadUserProfile(_ error: APIErrors) {
        setupErrorView()
    }
    
    private func updateUI(with model: UserProfile) {
        print(model.displayName)
        print(model.product)
        print(model.email)
    }
    
    private func setupErrorView() {
        view.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bannerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

#Preview {
    UINavigationController(rootViewController: UserProfileVC())
}
