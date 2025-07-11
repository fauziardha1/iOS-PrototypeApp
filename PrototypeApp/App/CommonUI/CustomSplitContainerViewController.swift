//
//  CustomSplitContainerViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 11/07/25.
//
import UIKit

class CustomSplitContainerViewController: UIViewController {
    let menuViewController: MenuViewController
    var detailViewController: UIViewController
    var menuWidthConstraint: NSLayoutConstraint!
    private var isMinimized: Bool = false

    init(menu: MenuViewController, detail: UIViewController) {
        self.menuViewController = menu
        self.detailViewController = detail
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(menuViewController)
        addChild(detailViewController)
        view.addSubview(menuViewController.view)
        view.addSubview(detailViewController.view)
        menuViewController.didMove(toParent: self)
        detailViewController.didMove(toParent: self)

        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        detailViewController.view.translatesAutoresizingMaskIntoConstraints = false

        menuWidthConstraint = menuViewController.view.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([
            menuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuWidthConstraint,

            detailViewController.view.leadingAnchor.constraint(equalTo: menuViewController.view.trailingAnchor),
            detailViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            detailViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func minimizeMenu(_ minimized: Bool) {
        isMinimized.toggle()
        menuWidthConstraint.constant = isMinimized ? 60 : 200
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        menuViewController.minimized()
    }
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        // Remove old detail view controller
        detailViewController.willMove(toParent: nil)
        detailViewController.view.removeFromSuperview()
        detailViewController.removeFromParent()

        // Add new detail view controller
        detailViewController = vc
        addChild(detailViewController)
        view.addSubview(detailViewController.view)
        detailViewController.didMove(toParent: self)

        // Set up constraints for the new detail view
        detailViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailViewController.view.leadingAnchor.constraint(equalTo: menuViewController.view.trailingAnchor),
            detailViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            detailViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.layoutIfNeeded()
    }
}
