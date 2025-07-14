//
//  AppRoutes.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit
import Domain // Import the new domain layer enums

/**
 This file defines the app's routing structure and navigation logic.
*/

/**
 Protocol that defines navigation actions for the app.
 */
protocol AppRouting {
    /**
     Navigates to the specified route from a given view controller.
     - Parameters:
        - route: The destination route to navigate to.
        - from: The source UIViewController (optional).
     */
    func navigate(to route: AppRoute, from: UIViewController?)
}

/**
 AppRouter is responsible for handling navigation and routing logic throughout the app.
 It supports both iPad (sidebar) and iPhone (tab bar) navigation structures.
 */
final class AppRouter: AppRouting {
    /// Reference to the main application window.
    private weak var window: UIWindow?
    /// Main navigation controller for stack-based navigation.
    private let navigationController: UINavigationController
    /// Factory for creating feature view controllers.
    var factory: FeatureFactory?
    /// Tab bar controller for iPhone navigation.
    private var tabBarController: UITabBarController?
    /// Sidebar controller for iPad navigation.
    private var sideBar: UIViewController?
    
    private var minimizedMenu: () -> Void = {}
    
    /**
     Initializes the AppRouter with the main window.
     - Parameter window: The UIWindow to use for root view controller assignment.
     */
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    /**
     Starts the routing logic by determining device type and showing the initial screen.
     */
    func start() {
        _ =  UIDevice.current.userInterfaceIdiom == .pad ? initiateSideBar() : initiateTabBar()
        navigate(to: .login)
    }
    
    /**
     Sets up the tab bar navigation for iPhone devices.
     */
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
    
    /**
     Sets up the sidebar navigation for iPad devices.
     */
    private func initiateSideBar() {
        
        let menuVC = factory?.makeSideBarMenu() ?? UIViewController()
        let menuNav = UINavigationController(rootViewController: menuVC)
        let detailVC = factory?.makeSideBarContent() ?? UIViewController()
        let detailNav = UINavigationController(rootViewController: detailVC)
        guard let menu = menuVC as? MenuViewController else { return }
        let splitViewController = CustomSplitContainerViewController(menu: menu, detail: detailNav)
        self.sideBar = splitViewController
        
        self.minimizedMenu = {
            splitViewController.minimizeMenu()
        }
    }

    /**
     Navigates to the specified route, handling device-specific navigation logic.
     - Parameters:
        - route: The destination route to navigate to.
        - from: The source UIViewController (optional).
     */
    func navigate(to route: AppRoute, from: UIViewController? = nil) {
        switch route {
            case .login:
                let vc = factory?.makeLogin() ?? UIViewController()
                if UIDevice.current.userInterfaceIdiom == .pad {
                    let loginNav = UINavigationController(rootViewController: vc)
                    window?.rootViewController = loginNav
                    return
                }
                
                navigationController.setViewControllers([vc], animated: true)
            
            case .home:
                if UIDevice.current.userInterfaceIdiom == .pad {
                    guard let sideBar, let window else { return }
                    let homeVc = factory?.makeHome() ?? UIViewController()
                    if let detail = homeVc as? DetailBaseViewController {
                        detail.minimizedMainMenu = minimizedMenu
                    }
                    let homeNav = UINavigationController(rootViewController: homeVc)
                    sideBar.showDetailViewController(homeNav, sender: nil)
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
                    if let detail = vc as? DetailBaseViewController {
                        detail.minimizedMainMenu = minimizedMenu
                    }
                    let profileNav = UINavigationController(rootViewController: vc)
                    sideBar.showDetailViewController(profileNav, sender: from)
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
                    if let detail = vc as? DetailBaseViewController {
                        detail.minimizedMainMenu = minimizedMenu
                    }
                    let settingsNav = UINavigationController(rootViewController: vc)
                    sideBar.showDetailViewController(settingsNav, sender: nil)
                    return
                }
                navigationController.pushViewController(vc, animated: true)
            
            case .changePassword:
                let vc = factory?.makeChangePassword() ?? UIViewController()
                if  let sideBar = sideBar as? CustomSplitContainerViewController,
                    let detailNav = (sideBar.detailViewController as? UINavigationController) {
                        detailNav.pushViewController(vc, animated: true)
                        return
                }
                navigationController.pushViewController(vc, animated: false)
        }
    }
}
