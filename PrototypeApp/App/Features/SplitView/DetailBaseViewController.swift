//
//  DetailBaseViewController.swift
//  PrototypeApp
//
//  Created by FauziArda on 11/07/25.
//

import UIKit

class DetailBaseViewController: UIViewController {
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
        guard let splitViewController = self.splitViewController else { return }
        let mode = splitViewController.preferredDisplayMode
        UIView.animate(withDuration: 0.3) {
            splitViewController.preferredDisplayMode = mode == .secondaryOnly ? .oneBesideSecondary : .secondaryOnly
            splitViewController.view.layoutIfNeeded()
        }
    }
}
