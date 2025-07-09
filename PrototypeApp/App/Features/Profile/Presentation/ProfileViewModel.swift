//
//  ProfileViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

class ProfileViewModel {
    var name: String = String()
    var email: String = String()
    var profilePictureURL: String = String()
    var goToHomeAction: () -> Void = {}
    var logOutAction: () -> Void = {}
    var view: ProfileDislayLogic?
    
    func navigateToSettings() {}
    
    func loadProfileData() {
        view?.displayProfileData("\(name), \(email), \(profilePictureURL)")
    }
        
    func logout() {
        logOutAction()
    }
    
    func goToHome() {
        goToHomeAction()
    }
}
