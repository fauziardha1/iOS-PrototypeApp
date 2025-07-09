//
//  ProfileUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

struct ProfileUIComposer {
    
    static func composeProfileViewController(router: AppRouting, input: ProfileInput) -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        viewModel.view = viewController
        viewModel.email = input.email
        viewModel.name = input.name
        viewModel.profilePictureURL = input.url
        viewModel.goToHomeAction = {
            router.navigate(to: .home, from: viewController)
        }
        viewModel.logOutAction = {
            router.navigate(to: .login, from: viewController)
        }
        return viewController
    }
}

struct ProfileInput {
    let email: String
    let name: String
    let url: String
    
    init(email: String, name: String, url: String) {
        self.email = email
        self.name = name
        self.url = url
    }
}

