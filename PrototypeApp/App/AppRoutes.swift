//
//  AppRoutes.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit
// This file defines the app's routing structure and navigation logic.
enum AppRoute {
    case login
    case home
    case profile
    // Add more cases as app grows
}

protocol AppRouting {
    func navigate(to route: AppRoute, from: UIViewController?)
}

final class AppRouter: AppRouting {
    private weak var window: UIWindow?
    private let navigationController: UINavigationController
    var factory: FeatureFactory?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        // Start the app with the login screen
        navigate(to: .login)
    }

    func navigate(to route: AppRoute, from: UIViewController? = nil) {
        switch route {
        case .login:
            let vc = factory?.makeLogin() ?? UIViewController()
            navigationController.setViewControllers([vc], animated: true)
        case .home:
            let vc = factory?.makeHome() ?? UIViewController()
            navigationController.setViewControllers([vc], animated: true)
            
        case .profile:
            let vc = factory?.makeProfile() ?? UIViewController()
            navigationController.pushViewController(vc, animated: true)
            break;
        }
    }
}
