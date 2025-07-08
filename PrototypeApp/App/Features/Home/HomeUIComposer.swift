//
//  HomeUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

struct HomeUIComposer {
    
    static func composeHomeViewController(router: AppRouting) -> UIViewController {
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

