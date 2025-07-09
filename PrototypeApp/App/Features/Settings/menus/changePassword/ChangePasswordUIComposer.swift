//
//  ChangePasswordUIComposer.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/25.
//
import UIKit
struct ChangePasswordUIComposer {
    static func makeChangePassword( router: AppRouting) -> UIViewController {
        let controller = ChangePasswordViewController()
        let viewModel = ChangePasswordViewModel()
        controller.viewModel = viewModel
        
        return controller
    }
}
