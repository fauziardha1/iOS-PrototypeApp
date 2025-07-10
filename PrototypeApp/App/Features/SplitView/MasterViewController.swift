//
//  MasterViewController.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 30/09/24.
//

import UIKit

class MenuViewController: UITableViewController {
    var viewModel: MenuViewModel?
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewModel?.loadMenus()
        selectFirstMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.selectRow(at: selectedIndex, animated: false, scrollPosition: .none)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else { return .zero }
        return viewModel.menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.menus[indexPath.row] ?? String()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel else { return }
        self.selectedIndex = indexPath
        viewModel.navigateTo(indexPath.row)
    }
    
    func selectFirstMenu() {
        guard let viewModel else { return }
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        viewModel.navigateTo(selectedIndex.row)
    }
}

protocol MenuDisplayLogic {
    func load(menus: [String])
}


extension MenuViewController: MenuDisplayLogic {
    func load(menus: [String]) {
        tableView.reloadData()
    }
}
