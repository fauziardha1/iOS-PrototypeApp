//
//  MasterViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 30/09/24.
//

import UIKit

class MenuViewController: UITableViewController {
    let menuItems = ["Item 1", "Item 2", "Item 3"]
    // Property to keep track of the currently selected row
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        selectFirstMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.selectRow(at: selectedIndex, animated: false, scrollPosition: .none)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        showDetailContent(for: menuItems[indexPath.row])
    }
    
    func selectFirstMenu() {
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        showDetailContent(for: menuItems[selectedIndex.row])
    }
    
    func showDetailContent(for menu: String) {
        let detailVC = ContentViewController()
        detailVC.updateContent(with: menu)
        
        if let splitViewController = self.splitViewController {
            let detailNavController = UINavigationController(rootViewController: detailVC)
            splitViewController.showDetailViewController(detailNavController, sender: nil)
        }
    }
}
