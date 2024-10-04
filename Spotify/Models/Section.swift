//
//  Section.swift
//  Spotify
//
//  Created by Yerkebulan on 09.09.2024.
//

import Foundation
import UIKit
struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let vc: UIViewController
}

