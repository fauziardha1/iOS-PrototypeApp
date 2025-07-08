//
//  LoginViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the view controller's UI
        self.view.backgroundColor = .white
        self.title = "Login"
        setupUI()
    }
    
    private func setupUI() {
        // Add UI elements like text fields, buttons, etc.
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Additional UI setup can be done here
    }

    @objc private func loginButtonTapped() {
        // Handle login button tap
        // For now, just print a message
        print("Login button tapped")
        viewModel?.login(username: "name", password: "password")
        
        // Navigate to the home screen or perform login logic
        // Example: router.navigate(to: .home, from: self)
    }


}
