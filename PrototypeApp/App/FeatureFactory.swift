//
//  FeatureFactory.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit
import Domain

protocol FeatureFactory {
    func makeLogin() -> UIViewController
    func makeHome() -> UIViewController
    func makeProfile() -> UIViewController
    func makeSettings() -> UIViewController
    func makeChangePassword() -> UIViewController
    func makeSideBarMenu() -> UIViewController
    func makeSideBarContent() -> UIViewController
    // add other features if needed
}


struct DefaultFeatureFactory: FeatureFactory {
    
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func makeLogin() -> UIViewController {
        return LoginUIComposer.composeLoginViewController(router: router)
    }
    
    func makeHome() -> UIViewController {
        return HomeUIComposer.composeHomeViewController(router: router)
    }
    
    func makeProfile() -> UIViewController {
        let profileInput = ProfileInput(email: "email@gmail.com", name: "John", url: "https://google.com")
        return ProfileUIComposer.composeProfileViewController(router: router, input: profileInput)
    }
    
    func makeSettings() -> UIViewController {
        return SettingsUIComposer.makeSettings(router: router)
    }
    
    func makeChangePassword() -> UIViewController {
        return ChangePasswordUIComposer.makeChangePassword(router: router)
    }
    
    func makeSideBarMenu() -> UIViewController {
        let menuViewController = MenuViewController()
        let menuViewModel = MenuViewModel()
        menuViewModel.getMenus = { AppMainMenu.allCases.map { AppMainMenu.getRawValue(of: $0) }}
        menuViewModel.view = menuViewController
        menuViewController.viewModel = menuViewModel
        menuViewController.selectFirstMenu()
        menuViewModel.actionNavigateTo = { index in
            let menu = AppMainMenu.allCases[index]
            switch menu {
                case .home:
                router.navigate(to: .home, from: nil)
                print("home")
                case .profile:
                router.navigate(to: .profile, from: nil)
                print("profile")
                
                case .settings:
                router.navigate(to: .settings, from: nil)
                print("settings")
            }
        }
        
        return menuViewController
    }
    
    func makeSideBarContent() -> UIViewController {
        let vc = ContentViewController()
        return vc
    }
    
    // Add other feature compositions here if needed
}




