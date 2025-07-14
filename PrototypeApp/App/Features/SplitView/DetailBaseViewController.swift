//
//  DetailBaseViewController.swift
//  PrototypeApp
//
//  Created by FauziArda on 11/07/25.
//

import UIKit

class DetailBaseViewController: UIViewController {
    var minimizedMainMenu: () -> Void = {}
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            let burgerButton = UIBarButtonItem(
                image: UIImage(systemName: "line.horizontal.3"),
                style: .plain,
                target: self,
                action: #selector(toggleMenu)
            )
            navigationItem.leftBarButtonItem = burgerButton
        }
        
        // banner button
        let bannerButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: self,
            action: #selector(bannerTapped)
        )
        
        navigationItem.rightBarButtonItem = bannerButton
    }

    @objc func toggleMenu() {
       minimizedMainMenu()
        if let splitViewController = self.splitViewController {
            splitViewController.view.setNeedsLayout()
        }
    }
    
    @objc func bannerTapped() {
        let messages = ["Welcome to the app!", "New features available!", "Don't miss our latest updates!"]
        NotificationBannerViewModel.shared.message = messages.randomElement() ?? "No messages available"
    }
        
}
