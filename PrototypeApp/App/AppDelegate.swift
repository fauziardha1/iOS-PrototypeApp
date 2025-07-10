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
        print("App has launched.")
        window = UIWindow(frame: UIScreen.main.bounds)
        let router = AppRouter(window: window)
        let factory = DefaultFeatureFactory(router: router)
        router.factory = factory
        router.start()
        return true
    }
    
    // Called when the app is about to enter the background
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App is in the background.")
        // Save data, release shared resources, etc.
    }

    // Called when the app is about to enter the foreground
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App is about to enter the foreground.")
        // Undo changes made on entering the background
    }

    // Called when the app has become active
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App has become active.")
        // Restart any tasks that were paused
    }

    // Called when the app is about to terminate
    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminate.")
        // Save data if appropriate
    }

}

