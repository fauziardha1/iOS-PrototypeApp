//
//  MasterViewModel.swift
//  PrototypeApp
//
//  Created by Fauzi Arda on 10/07/25.
//

class MenuViewModel {
    var menus: [String] = []
    var view: MenuDisplayLogic?
    var getMenus: () -> [String] = {[]}
    var actionNavigateTo: (Int) -> Void = {_ in }
    var menuIcons: [String] = []
    
    func loadMenus() {
        self.menus = getMenus()
        self.menuIcons = ["house.fill", "person.fill", "gear.circle.fill"]
        view?.load(menus: menus)
    }
    
    func navigateTo(_ index: Int) {
        actionNavigateTo(index)
    }
}
