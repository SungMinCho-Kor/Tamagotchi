//
//  ChangeRootViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 2/22/25.
//

import UIKit

extension UIViewController {
    func changeRootViewController(
        _ targetViewController: UIViewController,
        animated: Bool
    ) {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(
            targetViewController,
            animated: true
        )
    }
}

extension SceneDelegate {
    func changeRootViewController(
        _ targetViewController: UIViewController,
        animated: Bool
    )  {
        guard let window = self.window else { return }
        window.rootViewController = targetViewController
        
        UIView.transition(
            with: window,
            duration: 0.2,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
}
