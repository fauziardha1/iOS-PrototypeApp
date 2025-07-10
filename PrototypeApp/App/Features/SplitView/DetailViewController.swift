//
//  DetailViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 30/09/24.
//

import UIKit

class ContentViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Add a custom burger button to toggle the menu (primary view)
       let burgerButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(toggleMenu))
       navigationItem.leftBarButtonItem = burgerButton
    }
    
    func updateContent(with text: String) {
        label.text = "Detail content \(text)"
        title = text
    }
    
    @objc func toggleMenu() {
        // Show the primary view (menu) when the button is tapped
        guard let splitViewController else { return }
        let mode = splitViewController.preferredDisplayMode
        
        
        // Animate the transition between display modes
        UIView.animate(withDuration: 0.3, animations: {
            // Toggle between showing and hiding the menu (primary view)
            splitViewController.preferredDisplayMode =  mode == .secondaryOnly ? .oneBesideSecondary : .secondaryOnly
            splitViewController.view.layoutIfNeeded() // Ensure the view is re-laid out smoothly
        })
    }
}
