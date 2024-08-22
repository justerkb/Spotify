//
//  TabBarController.swift
//  Spotify
//
//  Created by Yerkebulan on 20.08.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UINavigationController(rootViewController: SearchVC())
        let homeBar = UINavigationController(rootViewController: HomeVC())
        let libaryBar = UINavigationController(rootViewController: LibaryVC())

        searchBar.navigationItem.largeTitleDisplayMode = .always
        homeBar.navigationItem.largeTitleDisplayMode = .always
        libaryBar.navigationItem.largeTitleDisplayMode = .always
        
        searchBar.navigationBar.prefersLargeTitles = true
        homeBar.navigationBar.prefersLargeTitles = true
        libaryBar.navigationBar.prefersLargeTitles = true


        searchBar.tabBarItem = UITabBarItem(title: "Search", image:UIImage(systemName: "magnifyingglass"), tag: 1)
        homeBar.tabBarItem = UITabBarItem(title: "Home", image:UIImage(systemName: "house"), tag: 2)
        libaryBar.tabBarItem = UITabBarItem(title: "Your Libary", image:UIImage(systemName: "book"), tag: 3)

        
        self.setViewControllers([homeBar, searchBar, libaryBar], animated: true)
        UITabBar.appearance().tintColor = .white
        self.tabBar.barTintColor = .systemBackground
    }
}
