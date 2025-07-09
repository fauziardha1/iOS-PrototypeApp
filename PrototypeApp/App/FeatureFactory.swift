//
//  FeatureFactory.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

protocol FeatureFactory {
    func makeLogin() -> UIViewController
    func makeHome() -> UIViewController
    func makeProfile() -> UIViewController
    func makeSettings() -> UIViewController
    func makeChangePassword() -> UIViewController
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
    // Add other feature compositions here if needed
}




