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
    case showDetail(AppMainMenu)
    // Add more cases as app grows
}

enum AppMainMenu: CaseIterable {
    case home
    case profile
    case settings
    
    static func getRawValue(of type: AppMainMenu) -> String {
        switch type {
            case .home: return "Home"
            case .profile: return "Profile"
            case .settings: return "Setting"
        }
    }
}

protocol AppRouting {
    func navigate(to route: AppRoute, from: UIViewController?)
}

final class AppRouter: AppRouting {
    private weak var window: UIWindow?
    private let navigationController: UINavigationController
    var factory: FeatureFactory?
    private var tabBarController: UITabBarController?
    private var sideBar: UISplitViewController?
    private var sideBarDetailNav: UINavigationController?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        _ =  UIDevice.current.userInterfaceIdiom == .pad ? initiateSideBar() : initiateTabBar()
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
    
    private func initiateSideBar() {
        let splitViewController = UISplitViewController()
        let menuVC = factory?.makeSideBarMenu() ?? UIViewController()
        let menuNav = UINavigationController(rootViewController: menuVC)
        let detailVC = factory?.makeSideBarContent() ?? UIViewController()
        let detailNav = UINavigationController(rootViewController: detailVC)
        splitViewController.viewControllers = [menuNav, detailNav]
        splitViewController.preferredDisplayMode = .automatic
        
        self.sideBar = splitViewController
    }

    func navigate(to route: AppRoute, from: UIViewController? = nil) {
        switch route {
            case .login:
                let vc = factory?.makeLogin() ?? UIViewController()
                navigationController.setViewControllers([vc], animated: true)
            
            case .home:
                if UIDevice.current.userInterfaceIdiom == .pad {
                    guard let sideBar, let window else { return }
                    let vc = factory?.makeHome() ?? UIViewController()
                    sideBar.showDetailViewController(vc, sender: nil)
                    window.rootViewController = sideBar
                    return
                }
                guard let tabBarController else { return }
                navigationController.setViewControllers([tabBarController], animated: true)
            
            case .profile:
                if let tabBarController {
                    tabBarController.selectedIndex = 1
                    return
                }
            
                let vc = factory?.makeProfile() ?? UIViewController()
                if let sideBar {
                    sideBar.showDetailViewController(vc, sender: from)
                    return
                }
            
                navigationController.pushViewController(vc, animated: true)
                break;
            
            case .settings:
                if let tabBarController {
                    tabBarController.selectedIndex = 2
                    return
                }
    
                let vc = factory?.makeSettings() ?? UIViewController()
                if let sideBar {
                    sideBar.showDetailViewController(vc, sender: nil)
                    return
                }
                navigationController.pushViewController(vc, animated: true)
            
            case .changePassword:
                let vc = factory?.makeChangePassword() ?? UIViewController()
                if let sideBar {
                    sideBar.showDetailViewController(vc, sender: from)
                    return
                }
                navigationController.pushViewController(vc, animated: false)
            
            case .showDetail(let menu):
                guard let sideBarDetailNav else { return }
            
                switch menu {
                    case .home:
                        let vc = factory?.makeHome() ?? UIViewController()
                        sideBarDetailNav.setViewControllers([vc], animated: true)
                    
                    case .profile:
                        let vc = factory?.makeProfile() ?? UIViewController()
                        sideBarDetailNav.setViewControllers([vc], animated: true)
                    
                    case .settings:
                        let vc = factory?.makeSettings() ?? UIViewController()
                        sideBarDetailNav.setViewControllers([vc], animated: true)
                }
                break;
        }
    }
}
