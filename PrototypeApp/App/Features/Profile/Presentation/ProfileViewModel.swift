//
//  ProfileViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

class ProfileViewModel {
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func navigateToSettings() {
        // Navigate to settings screen
//        router.navigate(to: .settings, from: nil)
    }
    
    func logout() {
        // Perform logout logic here
        // On success, navigate to login
        router.navigate(to: .login, from: nil)
    }



}
