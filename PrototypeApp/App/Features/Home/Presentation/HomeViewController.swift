//
//  HomeViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        title = "Home"
        // Setup UI elements and constraints here
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Home"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        // button go to profile
        let profileButton = UIButton(type: .system)
        profileButton.setTitle("Go to Profile", for: .normal)
        profileButton.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.backgroundColor = .systemBlue
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.layer.cornerRadius = 5
        
        self.view.addSubview(profileButton)
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            profileButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // button logout
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.backgroundColor = .white
        logoutButton.setTitleColor(.systemBlue, for: .normal)
        logoutButton.layer.cornerRadius = 5
        
        self.view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            logoutButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func goToProfile() {
        // Handle navigation to profile
        viewModel?.navigateToProfile()
    }
    
    @objc private func logoutButtonTapped() {
        // Handle logout
        viewModel?.logout()
    }
}





