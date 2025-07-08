//
//  LoginViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

class LoginViewModel {
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func login(username: String, password: String) {
        // Perform login logic here
        // On success, navigate to home
        router.navigate(to: .home, from: nil)
    }
    
}



