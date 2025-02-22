//
//  CommonNavigationController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import UIKit

final class CommonNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.servicePrimary]
        barAppearance.backgroundColor = .serviceBackground
        self.navigationBar.standardAppearance = barAppearance
        self.navigationBar.scrollEdgeAppearance = barAppearance
    }
}
