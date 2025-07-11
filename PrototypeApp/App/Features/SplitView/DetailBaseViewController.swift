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
    }

    @objc func toggleMenu() {
       minimizedMainMenu()
        if let splitViewController = self.splitViewController {
            splitViewController.view.setNeedsLayout()
        }
    }
}
