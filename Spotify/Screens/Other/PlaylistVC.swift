//
//  PlaylistVC.swift
//  Spotify
//
//  Created by Yerkebulan on 20.10.2024.
//

import UIKit

class PlaylistVC: UIViewController {
    private var playlist: Playlist
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Playlist"
        print(playlist)
    }
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
