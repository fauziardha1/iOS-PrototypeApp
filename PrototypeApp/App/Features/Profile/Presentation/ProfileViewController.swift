//
//  ProfileViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupView()
        viewModel?.loadProfileData()
    }
    
    private func setupView() {
        self.view.addSubview(label)
        self.view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
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

protocol ProfileDislayLogic {
    func displayProfileData(_ data: String)
}

extension ProfileViewController: ProfileDislayLogic {
    func displayProfileData(_ data: String) {
        label.text = data
    }
}
