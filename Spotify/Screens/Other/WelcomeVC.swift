//
//  WelcomeVC.swift
//  Spotify
//
//  Created by Yerkebulan on 21.08.2024.
//

import UIKit
class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Spotify"
        view.backgroundColor = .systemGreen
        
        navigationController?.pushViewController(AuthVC(), animated: true)
    }


}
