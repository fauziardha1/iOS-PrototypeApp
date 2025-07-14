//
//  ProfileViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import Combine
import Foundation

class ProfileViewModel {
    var name: String = String()
    var email: String = String()
    var profilePictureURL: String = String()
    var goToHomeAction: () -> Void = {}
    var logOutAction: () -> Void = {}
    var view: ProfileDislayLogic?
    var cancellables = Set<AnyCancellable>()
    @Published var content: String = "Loading profile data..."
    
    func navigateToSettings() {}
    
    func loadProfileData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.content = "\(self.name), \(self.email), \(self.profilePictureURL)"
        }
//        view?.displayProfileData("\(name), \(email), \(profilePictureURL)")
    }
        
    func logout() {
        logOutAction()
    }
    
    func goToHome() {
        goToHomeAction()
    }
}
