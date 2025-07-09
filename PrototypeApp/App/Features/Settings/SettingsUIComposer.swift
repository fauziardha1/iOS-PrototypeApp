//
//  SettingsUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/25.
//
import UIKit
struct SettingsUIComposer {
    
    static func makeSettings(router: AppRouting) -> UIViewController {
        let controller = SettingsViewController()
        let viewModel = SettingsViewModel()
        controller.viewModel = viewModel
        viewModel.view = controller
        
        viewModel.goToChangePasswordAction = {
            router.navigate(to: .changePassword, from: controller)
        }
        return controller
    }
}
