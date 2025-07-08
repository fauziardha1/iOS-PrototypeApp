//
//  ProfileViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        self.title = "Profile"
    }
    
    @objc private func settingsTapped() {
        // Handle settings action
        viewModel?.navigateToSettings()
    }
    
    @objc private func logoutTapped() {
        // Handle logout action
        viewModel?.logout()
    }
}
