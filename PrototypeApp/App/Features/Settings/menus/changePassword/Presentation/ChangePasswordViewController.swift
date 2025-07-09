//
//  ChangePasswordViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 09/07/25.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var viewModel: ChangePasswordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = "Change Password"
        self.view.backgroundColor = .white
    }
}
