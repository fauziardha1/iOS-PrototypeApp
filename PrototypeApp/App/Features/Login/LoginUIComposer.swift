//
//  LoginUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

struct LoginUIComposer {
    
    static func composeLoginViewController(router: AppRouting) -> UIViewController {
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

