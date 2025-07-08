//
//  ProfileUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

struct ProfileUIComposer {
    
    static func composeProfileViewController(router: AppRouting) -> UIViewController {
        let viewModel = ProfileViewModel(router: router)
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

