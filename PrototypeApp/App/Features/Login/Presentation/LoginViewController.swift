//
//  LoginViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 07/07/25.
//

import UIKit
import GoogleSignIn

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
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // Google Sign-In button
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleSignInButton)
        NSLayoutConstraint.activate([
            googleSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleSignInButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
        
        googleSignInButton.addTarget(self, action: #selector(googleSignInTapped), for: .touchUpInside)
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
    
    @objc func googleSignInTapped() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            self.viewModel?.login(username: "\(signInResult?.user.profile?.email ?? "")", password: "\(signInResult?.user.profile?.name ?? "")")
            print("\(String(describing: signInResult?.user.profile?.email))", "\(String(describing: signInResult?.user.profile?.name))")
            // If sign in succeeded, display the app's main content View.
        }
    }


}
