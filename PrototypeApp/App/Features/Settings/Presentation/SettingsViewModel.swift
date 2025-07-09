//
//  SettingsViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/25.
//

import Foundation

class SettingsViewModel {
    var menus: [String] = []
    var view: SettingsDisplayLogic?
    var goToChangePasswordAction: () -> Void = {}
    
    func loadMenu() {
        menus = ["Change Password", "Others"]
        view?.load(menu: menus)
    }
    
    func goToChangePassword() {
        self.goToChangePasswordAction()
    }
    
}
