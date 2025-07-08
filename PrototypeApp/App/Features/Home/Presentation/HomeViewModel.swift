//
//  HomeViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

class HomeViewModel {
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func navigateToProfile() {
        // Navigate to profile screen
        router.navigate(to: .profile, from: nil)
    }
    
    func logout() {
        // Perform logout logic here
        // On success, navigate to login
        router.navigate(to: .login, from: nil)
    }
}



