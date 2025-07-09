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
    case settings
    case changePassword
    // Add more cases as app grows
}

protocol AppRouting {
    func navigate(to route: AppRoute, from: UIViewController?)
}

final class AppRouter: AppRouting {
    private weak var window: UIWindow?
    private let navigationController: UINavigationController
    var factory: FeatureFactory?
    private var tabBarController: UITabBarController?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        initiateTabBar()
        // Start the app with the login screen
        navigate(to: .login)
    }
    
    private func initiateTabBar() {
        let tabBar = UITabBarController()
        let homeVC = factory?.makeHome() ?? UIViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        // Settings tab for Profile
        let profileVC = factory?.makeProfile() ?? UIViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        // Settings tab for settings
        let settingsVC = factory?.makeSettings() ?? UIViewController()
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 2)
    
        tabBar.viewControllers = [homeNav, profileNav, settingsNav]
        tabBar.selectedIndex = 0
    
        self.tabBarController = tabBar
    }

    func navigate(to route: AppRoute, from: UIViewController? = nil) {
        switch route {
            case .login:
                let vc = factory?.makeLogin() ?? UIViewController()
                navigationController.setViewControllers([vc], animated: true)
            case .home:
                guard let tabBarController else { return }
                navigationController.setViewControllers([tabBarController], animated: true)
            
            case .profile:
                if let tabBarController {
                    tabBarController.selectedIndex = 1
                    return
                }
                let vc = factory?.makeProfile() ?? UIViewController()
                navigationController.pushViewController(vc, animated: true)
                break;
            
            case .settings:
                if let tabBarController {
                    tabBarController.selectedIndex = 2
                    return
                }
                let vc = factory?.makeSettings() ?? UIViewController()
                navigationController.pushViewController(vc, animated: true)
            
            case .changePassword:
                let vc = factory?.makeChangePassword() ?? UIViewController()
                navigationController.pushViewController(vc, animated: false)
        }
    }
}
