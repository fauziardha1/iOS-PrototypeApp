//
//  AppDelegate.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return makeSplitView()
    }
    
    private func makeViewController() -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    private func makeSplitView() -> Bool {
        let splitViewController = UISplitViewController()
                
        // Create the master (menu) view controller
        let menuViewController = MenuViewController()
        let menuNavController = UINavigationController(rootViewController: menuViewController)
        
        // Create the detail (content) view controller
        let detailViewController = ContentViewController()
        let detailNavController = UINavigationController(rootViewController: detailViewController)
        
        // Set the view controllers of the split view controller
        splitViewController.viewControllers = [menuNavController, detailNavController]
        splitViewController.preferredDisplayMode = .automatic
        menuViewController.selectFirstMenu()
        
        // Assign the split view controller as the window's root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

}

